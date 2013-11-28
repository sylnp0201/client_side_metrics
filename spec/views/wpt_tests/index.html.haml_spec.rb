require 'spec_helper'

describe "wpt_tests/index" do
  before(:each) do
    assign(:wpt_tests, [
      stub_model(WptTest,
        :test_id => "Test",
        :xml => "MyText"
      ),
      stub_model(WptTest,
        :test_id => "Test",
        :xml => "MyText"
      )
    ])
  end

  it "renders a list of wpt_tests" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Test".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
