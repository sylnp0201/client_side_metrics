require 'spec_helper'

describe Webpagetest::WptRunner do
  WPT = Webpagetest
  let(:runner) { WPT::WptRunner.new }
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
      runner = WPT::WptRunner.new({ fvonly: true })
      runner.options[:fvonly].should == true
      runner.options[:key].should == 'eac005e6f6064286a4873096cf92c808'
    end

    it 'use test locations and url on test mode' do
      runner = WPT::WptRunner.new test: true
      runner.options[:locations].size == 1
      runner.options[:urls].size == 1
    end
  end

  describe '#submit_tests' do
    before do
      fake_resp_body = Utils::FakeResponse.fake_submit
      Utils::Url.stub(:request).and_return(double(body: fake_resp_body, code: '200'))
      WPT::RequestFactory.stub(:build_batch).and_return([{url: 'test_url', location: 'test_location'}])
    end

    it 'gets test id for submitted tests' do
      resp_recs = runner.submit_tests
      hash = resp_recs['131128_RQ_1KV']
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
      runner.instance_variable_set(:@response_records, {'test_id1' => { 'location' => 'loc1', 'url' => 'url1'}})
      Rails.logger.should_receive(:error).once
      runner.confirm_submission
    end

    it 'does nothing if all submission succeed' do
      resp_recs = {
        'test_id1' => { 'location' => 'loc1', 'url' => 'url1'},
        'test_id2' => { 'location' => 'loc2', 'url' => 'url1'}
      }
      runner.instance_variable_set(:@response_records, resp_recs)
      Rails.logger.should_receive(:error).never
      runner.confirm_submission
    end
  end

  describe '#check_batch_status' do
    let (:resp1) { double(code: '200', body: Utils::FakeResponse.cnn_status)}
    let (:resp2) { double(code: '200', body: Utils::FakeResponse.cnn_status)}
    it 'returns status codes of the tests' do
      Utils::Url.stub(:request).with('http://www.webpagetest.org/testStatus.php?f=xml&test=id1', nil).and_return(resp1)
      Utils::Url.stub(:request).with('http://www.webpagetest.org/testStatus.php?f=xml&test=id2', nil).and_return(resp2)
      runner.check_batch_status(['id1', 'id2']).should == { 'id1' => '200', 'id2' => '200' }
    end
  end

  describe '#gather_results' do
    it 'gets test results xml' do
      ids = ['131128_RQ_1KV']
      id_dom = runner.gather_results(ids)
      id_dom[ids.first].present?.should be_true
    end
  end

  describe '#wait_and_gather_results' do
    let(:id1) { '131128_RQ_1KV' }
    let(:id2) { '131128_6J_1ZF' }
    before do
      status1 = status2 = double(code: '200',
                                 body: Utils::FakeResponse.cnn_status)
      xml1 = xml2 = double(code: '200',
                           body: Utils::FakeResponse.cnn_xml)
      Utils::Url.stub(:request).with("http://www.webpagetest.org/testStatus.php?f=xml&test=#{id1}", nil).and_return(status1)
      Utils::Url.stub(:request).with("http://www.webpagetest.org/testStatus.php?f=xml&test=#{id2}", nil).and_return(status2)
      Utils::Url.stub(:request).with("http://www.webpagetest.org/xmlResult/#{id1}/", nil).and_return(xml1)
      Utils::Url.stub(:request).with("http://www.webpagetest.org/xmlResult/#{id2}/", nil).and_return(xml2)
    end
    it 'does what its name says' do

      resp_recs = {
        id1 => { location: 'loc1', url: 'url1'},
        id2 => { location: 'loc2', url: 'url1'}
      }
      runner.instance_variable_set(:@response_records, resp_recs)
      results = runner.wait_and_gather_results
      results.size.should == 2
      results[id1].present?.should be_true
      results[id2].present?.should be_true
    end
  end

  describe '#save_results' do
    before do
      r = {
        'test_id1' => 'test_xml1',
        'test_id2' => 'test_xml2'
      }
      runner.instance_variable_set(:@results, r)
      WPT::TestResultFactory.stub(:convert_data)
    end

    it 'creates record in db' do
      runner.save_results
      WptTest.all.size.should == 2
      WptTest.first.test_id.should == 'test_id1'
    end
  end

end