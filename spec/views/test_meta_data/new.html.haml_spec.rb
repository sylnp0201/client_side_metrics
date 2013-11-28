require 'spec_helper'

describe "test_meta_data/new" do
  before(:each) do
    assign(:test_meta_datum, stub_model(TestMetaDatum,
      :test_id => "MyString",
      :summary => "MyString",
      :test_url => "MyString",
      :page => "MyString",
      :location => "MyString",
      :browser => "MyString",
      :connectivity => "MyString",
      :runs => 1,
      :first_view_id => 1,
      :repeat_view_id => 1
    ).as_new_record)
  end

  it "renders new test_meta_datum form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", test_meta_data_path, "post" do
      assert_select "input#test_meta_datum_test_id[name=?]", "test_meta_datum[test_id]"
      assert_select "input#test_meta_datum_summary[name=?]", "test_meta_datum[summary]"
      assert_select "input#test_meta_datum_test_url[name=?]", "test_meta_datum[test_url]"
      assert_select "input#test_meta_datum_page[name=?]", "test_meta_datum[page]"
      assert_select "input#test_meta_datum_location[name=?]", "test_meta_datum[location]"
      assert_select "input#test_meta_datum_browser[name=?]", "test_meta_datum[browser]"
      assert_select "input#test_meta_datum_connectivity[name=?]", "test_meta_datum[connectivity]"
      assert_select "input#test_meta_datum_runs[name=?]", "test_meta_datum[runs]"
      assert_select "input#test_meta_datum_first_view_id[name=?]", "test_meta_datum[first_view_id]"
      assert_select "input#test_meta_datum_repeat_view_id[name=?]", "test_meta_datum[repeat_view_id]"
    end
  end
end
