require 'spec_helper'

describe Webpagetest::WptRunner do
  let(:runner) { Webpagetest::WptRunner.new }
  describe '#initialize' do
    it 'sets default options if not assigned' do
      runner.options.should == {
        connectivity: "Cable",
        fvonly: 0,
        key: 'eac005e6f6064286a4873096cf92c808',
        proxy: nil,
        runs: 1,
        test: false,
        locations: ["Dulles_IE7", "Dulles_IE8", "Dulles_IE9", "Dulles:Chrome"],
        urls: ["http://www.bloomberg.com", "http://www.bloomberg.com/news/2013-11-27/kamala-harris-bruises-banks-burnishes-image-with-mortgage-deals.html"]
      }
    end

    it 'keeps the assigned options values' do
      runner = Webpagetest::WptRunner.new({ fvonly: true })
      runner.options[:fvonly].should == true
      runner.options[:key].should == 'eac005e6f6064286a4873096cf92c808'
    end

    it 'use test locations and url on test mode' do
      runner = Webpagetest::WptRunner.new test: true
      runner.options[:locations].size == 1
      runner.options[:urls].size == 1
    end
  end

  describe '#submit_tests' do
    before do
      fake_resp_body = %Q|<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<response>\n<statusCode>200</statusCode>\n<statusText>Ok</statusText>\n<data>\n<testId>131127_XB_e4ef197a13b3ebeea58b1452fbbbb3be</testId>\n<ownerKey>4acd944ed93f456537c341ed6173656213f312cb</ownerKey>\n<xmlUrl>http://www.webpagetest.org/xmlResult/131127_XB_e4ef197a13b3ebeea58b1452fbbbb3be/</xmlUrl>\n<userUrl>http://www.webpagetest.org/result/131127_XB_e4ef197a13b3ebeea58b1452fbbbb3be/</userUrl>\n<summaryCSV>http://www.webpagetest.org/result/131127_XB_e4ef197a13b3ebeea58b1452fbbbb3be/page_data.csv</summaryCSV>\n<detailCSV>http://www.webpagetest.org/result/131127_XB_e4ef197a13b3ebeea58b1452fbbbb3be/requests.csv</detailCSV>\n<jsonUrl>http://www.webpagetest.org/jsonResult.php?test=131127_XB_e4ef197a13b3ebeea58b1452fbbbb3be/</jsonUrl>\n</data>\n</response>\n|
      Utils::Url.stub(:request).and_return(double(body: fake_resp_body, code: '200'))
      Webpagetest::RequestFactory.stub(:build_batch).and_return([{url: 'test_url', location: 'test_location'}])
    end

    it 'gets test id for submitted tests' do
      resp_recs = runner.submit_tests
      hash = resp_recs['131127_XB_e4ef197a13b3ebeea58b1452fbbbb3be']
      hash.should == {
        'location' => 'test_location',
        'url' => 'test_url' }
    end
  end

  describe '#confirm_test_submission' do
    before do
      runner.instance_variable_set(:@options, {
        locations: ['loc1', 'loc2'],
        urls: ['url1']
      })
    end

    it 'logs submission failures' do
      resp_recs = {'test_id1' => { location: 'loc1', url: 'url1'}}
      Rails.logger.should_receive(:error).once
      runner.confirm_test_submission(resp_recs)
    end

    it 'does nothing if all submission succeed' do
      resp_recs = {
        'test_id1' => { location: 'loc1', url: 'url1'},
        'test_id2' => { location: 'loc2', url: 'url1'}
      }
      Rails.logger.should_receive(:error).never
      runner.confirm_test_submission(resp_recs)
    end
  end

end