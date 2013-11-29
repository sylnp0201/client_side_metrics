require 'spec_helper'

describe Webpagetest::RequestFactory do
  describe '#build' do
    it 'builds a request' do
      factory = Webpagetest::RequestFactory.new({'f' => 'xml', 'private' => 1})
      factory.build.should == 'http://www.webpagetest.org/runtest.php?f=xml&private=1'
    end
  end

  describe '##build_batch' do
    let(:test_params) {
      {
        'f'       => 'xml',
        'private' => 1, #Set to 1 to keep the test hidden from the test log
        'fvonly'  => 1,
        'runs'    => 1,
        'k'       => 'eac005e6f6064286a4873096cf92c808'
      }
    }
    let(:urls) { Webpagetest::WptRunner::DEFAULT_URLS }
    let(:locations) { Webpagetest::WptRunner::DEFAULT_LOCATIONS }

    it 'builds a request batch' do
      request_batch = Webpagetest::RequestFactory.build_batch(urls, locations, true, test_params)
      request_batch.size.should == urls.size * locations.size
      request_batch.first[:request].include?('k=').should be_true
      request_batch.first[:request].include?('url').should be_true
      request_batch.first[:request].include?('location').should be_true
    end

    it 'generate beta cookie for beta site' do
      request_batch = Webpagetest::RequestFactory.build_batch(urls, locations, true, test_params)
      request_batch.first[:request].include?('script').should be_true
      request_batch.first[:request].include?('bbg_origin=beta').should be_true
    end

    it 'uses no script for normal site' do
      request_batch = Webpagetest::RequestFactory.build_batch(urls, locations, false, test_params)
      request_batch.first[:request].include?('script').should be_false
      request_batch.first[:request].include?('bbg_origin=beta').should be_false
    end
  end
end