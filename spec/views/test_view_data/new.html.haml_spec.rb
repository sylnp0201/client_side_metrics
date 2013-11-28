require 'spec_helper'

describe "test_view_data/new" do
  before(:each) do
    assign(:test_view_datum, stub_model(TestViewDatum,
      :load_time => 1,
      :first_byte => 1,
      :start_render => 1,
      :bytes_in => 1,
      :bytes_in_doc => 1,
      :requests => 1,
      :requests_doc => 1,
      :fully_loaded => 1,
      :doc_time => 1,
      :dom_elements => 1,
      :title_time => 1
    ).as_new_record)
  end

  it "renders new test_view_datum form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", test_view_data_path, "post" do
      assert_select "input#test_view_datum_load_time[name=?]", "test_view_datum[load_time]"
      assert_select "input#test_view_datum_first_byte[name=?]", "test_view_datum[first_byte]"
      assert_select "input#test_view_datum_start_render[name=?]", "test_view_datum[start_render]"
      assert_select "input#test_view_datum_bytes_in[name=?]", "test_view_datum[bytes_in]"
      assert_select "input#test_view_datum_bytes_in_doc[name=?]", "test_view_datum[bytes_in_doc]"
      assert_select "input#test_view_datum_requests[name=?]", "test_view_datum[requests]"
      assert_select "input#test_view_datum_requests_doc[name=?]", "test_view_datum[requests_doc]"
      assert_select "input#test_view_datum_fully_loaded[name=?]", "test_view_datum[fully_loaded]"
      assert_select "input#test_view_datum_doc_time[name=?]", "test_view_datum[doc_time]"
      assert_select "input#test_view_datum_dom_elements[name=?]", "test_view_datum[dom_elements]"
      assert_select "input#test_view_datum_title_time[name=?]", "test_view_datum[title_time]"
    end
  end
end
