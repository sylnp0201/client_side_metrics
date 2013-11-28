require 'spec_helper'

describe "test_meta_data/index" do
  before(:each) do
    assign(:test_meta_data, [
      stub_model(TestMetaDatum,
        :test_id => "Test",
        :summary => "Summary",
        :test_url => "Test Url",
        :page => "Page",
        :location => "Location",
        :browser => "Browser",
        :connectivity => "Connectivity",
        :runs => 1,
        :first_view_id => 2,
        :repeat_view_id => 3
      ),
      stub_model(TestMetaDatum,
        :test_id => "Test",
        :summary => "Summary",
        :test_url => "Test Url",
        :page => "Page",
        :location => "Location",
        :browser => "Browser",
        :connectivity => "Connectivity",
        :runs => 1,
        :first_view_id => 2,
        :repeat_view_id => 3
      )
    ])
  end

  it "renders a list of test_meta_data" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Test".to_s, :count => 2
    assert_select "tr>td", :text => "Summary".to_s, :count => 2
    assert_select "tr>td", :text => "Test Url".to_s, :count => 2
    assert_select "tr>td", :text => "Page".to_s, :count => 2
    assert_select "tr>td", :text => "Location".to_s, :count => 2
    assert_select "tr>td", :text => "Browser".to_s, :count => 2
    assert_select "tr>td", :text => "Connectivity".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
