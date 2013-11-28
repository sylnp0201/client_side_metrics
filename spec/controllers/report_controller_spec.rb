require 'spec_helper'

describe ReportController do
  describe '#parse_query_fields' do
    it 'parse string query fields into an array' do
      controller.parse_query_fields('requests')
      .include?('test_view_data.requests').should be_true
    end

    it 'always include the permanent fields' do
      arr = controller.parse_query_fields('requests')
      per_fields = ReportController::PERMANENT_FIELDS.map{|f| "test_meta_data.#{f}" }
      per_fields.each do |field|
        arr.include?(field).should be_true
      end
    end
  end

  describe '#set_default_options' do
    it 'set default value to unassigned options' do
      options = controller.set_default_options
      options['browser'].should == 'IE8'
    end

    it 'keeps the assigned options' do
      options = controller.set_default_options({'browser' => 'Safari'})
      options['browser'].should == 'Safari'
    end
  end

  describe '#index' do
    before do
      meta = FactoryGirl.build(:test_meta_datum)
      first_view = FactoryGirl.create(:test_view_datum, {load_time: 123})
      repeat_view = FactoryGirl.create(:test_view_datum, {load_time: 234})
      meta.first_view = first_view
      meta.repeat_view = repeat_view
      meta.save!
    end
    it 'respond to JSON format' do
      get :index, {format: 'json', browser: 'IE7'}
      resp = JSON.parse(response.body)
      p resp
      resp['first_view'][0][1]['load_time'].should == 123
      resp['repeat_view'][0][1]['load_time'].should == 234
    end
  end
end
