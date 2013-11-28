require 'spec_helper'

describe "wpt_tests/show" do
  before(:each) do
    @wpt_test = assign(:wpt_test, stub_model(WptTest,
      :test_id => "Test",
      :xml => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Test/)
    rendered.should match(/MyText/)
  end
end
