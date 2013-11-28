require 'spec_helper'

describe Webpagetest::TestResultFactory do
  Factory = Webpagetest::TestResultFactory
  Parser = Webpagetest::WptParser
  let (:wpt_test) { WptTest.create!({test_id: 'foo', xml: Utils::FakeResponse.cnn_xml}) }
  let (:factory) { Factory.new(wpt_test) }

  describe '#build' do
    it 'create a summary record in db' do
      factory.build
      TestViewDatum.all.size.should >= 2
      summary = TestMetaDatum.first
      summary.first_view.load_time.should == 3654
      summary.repeat_view.load_time.should == 1991
    end
  end

  describe '#build_summary' do
    it 'builds a meta data' do
      view = factory.build_summary
      view.should be_a(TestMetaDatum)
      view.test_id.should == '131128_RQ_1KV'
    end
  end

  describe '#build_view' do
    it 'builds a first view data' do
      view = factory.build_view('first_view')
      view.should be_a(TestViewDatum)
      view.load_time.should == 3654
    end

    it 'builds a repeat view data' do
      view = factory.build_view('repeat_view')
      view.should be_a(TestViewDatum)
      view.load_time.should == 1991
    end
  end
end