require 'spec_helper'

describe TestMetaDatum do
  TMD = TestMetaDatum
  let (:meta_params) { {location: 'Dulles', browser: 'IE8', page: 'homepage'} }
  let (:query_params) { meta_params.merge({since: 30.days.ago, fields: ['load_time']}) }

  describe '##sample_url' do
    before do
      TMD.create!({page: 'homepage', test_url: 'www.bloomberg.com'})
      TMD.create!({page: 'article', test_url: 'www.bloomberg.com/news/foo.html'})
    end
    it 'returns a sample url of the given page type' do
      TMD.sample_url('article').should == 'www.bloomberg.com/news/foo.html'
    end
  end

  describe "##associate_fields" do
    it 'prefix the coresponding table name with fields' do
      af = TMD.associate_fields(['test_id', 'first_byte'])
      af.size.should == 2
      af.should include('test_meta_data.test_id')
      af.should include('test_view_data.first_byte')
    end
  end

  describe 'time_series_data' do
    before do
      2.times do |i|
        meta = FactoryGirl.build(:test_meta_datum, {browser: 'IE8', location: 'Dulles'})
        first_view = FactoryGirl.create(:test_view_datum,  {load_time: 123 * (i+1)})
        repeat_view = FactoryGirl.create(:test_view_datum, {load_time: 234 * (i+1)})
        meta.first_view = first_view
        meta.repeat_view = repeat_view
        meta.save!
      end
    end

    it 'returns time series data' do
      series = TMD.time_series_data(:first_view, ['load_time', 'ran_at'], query_params)
      series.size.should == 2
      series[0][0].should >= 30.days.ago
      series[1][1][:load_time].should == 246
    end
  end

  describe '##recent_records' do
    before do
      3.times do |i|
        meta = FactoryGirl.build(:test_meta_datum, meta_params.merge({ran_at: i.days.ago}))
        first_view = FactoryGirl.create(:test_view_datum,  {load_time: 123 * (i+1)})
        repeat_view = FactoryGirl.create(:test_view_datum, {load_time: 234 * (i+1)})
        meta.first_view = first_view
        meta.repeat_view = repeat_view
        meta.save!
      end
    end

    it 'returns the most recent records' do
      results = TMD.recent_records(:first_view, query_params.merge({start_time: 2.days.ago}))
      results.length.should == 2
      results[0].load_time.should == 246
      results[1].load_time.should == 123
    end
  end

  describe '##twenty_four_hour_summary' do
    before do
      3.times do |i|
        meta = FactoryGirl.build(:test_meta_datum, meta_params.merge({ran_at: (i*20).hours.ago}))
        first_view = FactoryGirl.create(:test_view_datum,  {load_time: 123 * (i+1)})
        repeat_view = FactoryGirl.create(:test_view_datum, {load_time: 234 * (i+1)})
        meta.first_view = first_view
        meta.repeat_view = repeat_view
        meta.save!
      end
    end

    it 'returns a summary for records in 24 hours' do
      summary = TMD.twenty_four_hour_summary(:repeat_view, query_params)
      summary.should == { 'load_time' => (234 + 234*2)/2 }
    end
  end
end
