require 'spec_helper'

describe Webpagetest::RequestFactory do
  describe '#build' do
    it 'builds a request' do
      factory = Webpagetest::RequestFactory.new({'f' => 'xml', 'private' => 1})
      factory.build.should == 'http://www.webpagetest.org/runtest.php?f=xml&private=1'
    end
  end

  describe '##build_batch' do
    it 'builds a request batch' do
      test_params = {
        key: 'eac005e6f6064286a4873096cf92c808', # application key for webpagetest.org
        connectivity: 'Cable',
        fvonly: 0, # 0 to run both first and repeat view
        runs: 1
      }
      urls = Webpagetest::WptRunner::DEFAULT_URLS
      locations = Webpagetest::WptRunner::DEFAULT_LOCATIONS
      request_batch = Webpagetest::RequestFactory.build_batch(urls, locations, test_params)
      request_batch.size.should == urls.size * locations.size
      request_batch.first[:request].include?('key').should be_true
      request_batch.first[:request].include?('url').should be_true
      request_batch.first[:request].include?('location').should be_true
    end
  end
end