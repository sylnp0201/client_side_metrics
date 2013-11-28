require 'spec_helper'

describe "test_view_data/index" do
  before(:each) do
    assign(:test_view_data, [
      stub_model(TestViewDatum,
        :load_time => 1,
        :first_byte => 2,
        :start_render => 3,
        :bytes_in => 4,
        :bytes_in_doc => 5,
        :requests => 6,
        :requests_doc => 7,
        :fully_loaded => 8,
        :doc_time => 9,
        :dom_elements => 10,
        :title_time => 11
      ),
      stub_model(TestViewDatum,
        :load_time => 1,
        :first_byte => 2,
        :start_render => 3,
        :bytes_in => 4,
        :bytes_in_doc => 5,
        :requests => 6,
        :requests_doc => 7,
        :fully_loaded => 8,
        :doc_time => 9,
        :dom_elements => 10,
        :title_time => 11
      )
    ])
  end

  it "renders a list of test_view_data" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => 7.to_s, :count => 2
    assert_select "tr>td", :text => 8.to_s, :count => 2
    assert_select "tr>td", :text => 9.to_s, :count => 2
    assert_select "tr>td", :text => 10.to_s, :count => 2
    assert_select "tr>td", :text => 11.to_s, :count => 2
  end
end
