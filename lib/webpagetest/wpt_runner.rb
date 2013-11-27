class Webpagetest::WptRunner
  attr_reader :options

  DEFAULT_LOCATIONS = ['Dulles_IE7', 'Dulles_IE8', 'Dulles_IE9', 'Dulles:Chrome']
  DEFAULT_URLS = ['http://www.bloomberg.com', 'http://www.bloomberg.com/news/2013-11-27/kamala-harris-bruises-banks-burnishes-image-with-mortgage-deals.html']

  def initialize(parameters = {})
    @options = parameters
    set_defaults(options, default_options)
  end

  def run
    response_records = submit_tests
    confirm_test_submission response_records
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
    response_records
  end

  def confirm_test_submission(response_records)
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
end