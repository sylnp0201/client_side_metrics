class Webpagetest::WptRunner
  attr_reader :options
  attr_reader :response_records

  DEFAULT_LOCATIONS = ['Dulles_IE7', 'Dulles_IE8', 'Dulles_IE9', 'Dulles:Chrome']
  DEFAULT_URLS = ['http://www.bloomberg.com', 'http://www.bloomberg.com/news/2013-11-27/kamala-harris-bruises-banks-burnishes-image-with-mortgage-deals.html']

  def initialize(parameters = {})
    @options = parameters
    set_defaults(options, default_options)
  end

  def run
    submit_tests
    confirm_submission
    wait_and_gather_results
    check_results
  end

  def submit_tests
    request_batch = Webpagetest::RequestFactory.build_batch(options[:urls], options[:locations], test_params)
    response_records = {}
    request_batch.each do |test_request|
      resp = Utils::Url.request(test_request[:request], options[:proxy])
      return_code = resp.code
      if return_code == '200'
        parser = Utils::XmlParser.new(resp.body)
        if parser.status_code == '200'
          test_id = parser.test_id
          response_records[test_id] = { 'url' => test_request[:url], 'location' => test_request[:location] }
        end
      end
    end
    @response_records = response_records
  end

  def confirm_submission
    resp_urls = response_records.values.map{ |r| r[:url] }
    resp_locations = response_records.values.map{ |r| r[:location] }
    options[:urls].each do |url|
      options[:locations].each do |location|
        if !resp_urls.include?(url) || !resp_locations.include?(location)
          Rails.logger.error "Url or Location submission failed: #{url}, #{location}"
        end
      end
    end
  end

  def wait_and_gather_results
    results = {}
    pending_test_ids = response_records.keys
    timeout = Time.now + time_to_wait
    while true
      if pending_test_ids.blank?
        Rails.logger.info('The test is complete.')
        break
      end
      if Time.now >= timeout
        Rails.logger.error('Timeout: unable to finish the test.')
        break
      end

      id_status = check_batch_status(pending_test_ids)
      completed_test_ids = []
      id_status.each_pair do |id, status_code|
        # 1XX: Test in progress
        # 200: Test complete
        # 4XX: Test request not found
        status = status_code.to_i
        if status >= 200
          pending_test_ids.delete(id)
          if status == 200
            completed_test_ids.push(id)
          else
            Rails.logger.error("Tests failed with status #{test_status}: #{test_id}")
          end
        end
      end

      test_results = gather_results(completed_test_ids)
      results.merge!(test_results)
      completed_test_ids.each do |id|
        if !test_results.keys.include?(id)
          Rails.logger.error("The XML failed to retrieve: #{id}")
        end
      end
      sleep(30.seconds) if pending_test_ids.present?
    end
    results
  end

  def check_results
    # this needs real implementation
    p 'checking results'
  end

  def check_batch_status(ids)
    status = {}
    ids.each do |id|
      req = "http://www.webpagetest.org/testStatus.php?f=xml&test=#{id}"
      resp = Utils::Url.request(req, options[:proxy])
      if resp.code == '200'
        parser = Utils::XmlParser.new(resp.body)
        status[id] = parser.status_code
      end
    end
    status
  end

  def gather_results(ids)
    id_dom = {}
    ids.each do |id|
      request = "http://www.webpagetest.org/xmlResult/#{id}/"
      response = Utils::Url.request(request, options[:proxy])
      id_dom[id] = response.body if response.code == '200'
    end
    id_dom
  end

  private

  def set_defaults(options, defaults)
    options.reverse_merge!(defaults)
    options[:locations] = options[:test] ? ['Sydney_IE7'] : DEFAULT_LOCATIONS
    options[:urls] = options[:test] ? [DEFAULT_URLS.first] : DEFAULT_URLS
  end

  def default_options
    {
      key: 'eac005e6f6064286a4873096cf92c808', # application key for webpagetest.org
      connectivity: 'Cable',
      fvonly: 0, # 0 to run both first and repeat view
      runs: 1,
      proxy: nil,
      test: false
    }
  end

  def test_params
    {
      'f'       => 'xml',
      'private' => 1, #Set to 1 to keep the test hidden from the test log
      'fvonly'  => options[:fvonly],
      'runs'    => options[:runs],
      'k'       => options[:key]
    }
  end

  def time_to_wait
    # wait for 5 mins per run per location per url
    options[:runs] * options[:locations].size * options[:urls].size * 5 * 60
  end

end