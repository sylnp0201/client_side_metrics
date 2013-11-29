class Webpagetest::RequestFactory
  attr_reader :options
  def initialize(parameters)
    @options = parameters
  end

  def build
    query_str = Utils::Url.encode(Utils::Url.hash_to_query(options))
    "http://www.webpagetest.org/runtest.php?#{query_str}"
  end

  def self.build_batch(urls, locations, use_script, test_params)
    batch = []
    urls.each do |url|
      locations.each do |location|
        test_params.merge!({url: url, location: location})
        test_params.merge!({script: self.test_script(url)}) if use_script
        request = Webpagetest::RequestFactory.new(test_params).build
        batch << {
          location: location,
          url: url,
          request: request
        }
      end
    end
    batch
  end

  private

  def self.test_script(url)
    "setCookie  http://www.bloomberg.com  bbg_origin=beta\nnavigate #{url}"
  end
end