require 'spec_helper'

describe Webpagetest::WptParser do

  Parser = Webpagetest::WptParser

  let(:xml) { Utils::FakeResponse.cnn_xml }
  let (:parser) { Parser.new xml }

  describe '#initialize' do
    it 'convert the xml result to JSON'do
      p = Parser.new Utils::FakeResponse.google_status
      p.data.should == {"response" => {"statusCode"=>"100", "statusText"=>"Test Start"}}
    end
  end

  describe '#summary' do
    it 'returns the meta summary' do
      parser.summary.should == {
        browser: "IE9",
        connectivity: "Cable",
        location: "Dulles",
        page: "homepage",
        ran_at: "Thu, 28 Nov 2013 01:02:50 +0000",
        runs: 1,
        summary: "http://www.webpagetest.org/result/131128_RQ_1KV/",
        test_id: "131128_RQ_1KV",
        test_url: "http://www.cnn.com"
      }
    end
  end

  describe '#first_view' do
    it 'returns the details of the first view' do
      parser.first_view.should == {
        bytes_in: 3122744,
        bytes_in_doc: 1260693,
        doc_time: 3654,
        dom_elements: 1892,
        first_byte: 150,
        start_render: 1421,
        fully_loaded: 11931,
        load_time: 3654,
        requests: 240,
        requests_doc: 175,
        title_time: 256
      }
    end
  end

  describe '#repeat_view' do
    it 'returns the details of the repeat view' do
      parser.repeat_view.should == {
        bytes_in: 1181628,
        bytes_in_doc: 166790,
        doc_time: 1991,
        dom_elements: 1887,
        first_byte: 713,
        start_render: 684,
        fully_loaded: 12222,
        load_time: 1991,
        requests: 78,
        requests_doc: 49,
        title_time: 15
      }
    end
  end

  describe '#page_type' do
    it 'returns homepage if it has no /news/' do
      parser.page_type('http://www.bloomberg.com').should == 'homepage'
    end

    it 'returns article if it has /news/' do
      parser.page_type('http://www.bloomberg.com/news/foo.html').should == 'article'
    end
  end

  describe '#loc_bro' do
    it 'returns location and browser for IE' do
      parser.loc_bro('Dulles_IE8').should == ['Dulles', 'IE8']
    end

    it 'returns location and browser for other browsers' do
      parser.loc_bro('Sydney:Chrome').should == ['Sydney', 'Chrome']
    end
  end
end