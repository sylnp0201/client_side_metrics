require 'spec_helper'

describe "wpt_tests/new" do
  before(:each) do
    assign(:wpt_test, stub_model(WptTest,
      :test_id => "MyString",
      :xml => "MyText"
    ).as_new_record)
  end

  it "renders new wpt_test form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", wpt_tests_path, "post" do
      assert_select "input#wpt_test_test_id[name=?]", "wpt_test[test_id]"
      assert_select "textarea#wpt_test_xml[name=?]", "wpt_test[xml]"
    end
  end
end
