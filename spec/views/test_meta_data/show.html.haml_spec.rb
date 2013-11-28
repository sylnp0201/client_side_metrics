require 'spec_helper'

describe "test_meta_data/show" do
  before(:each) do
    @test_meta_datum = assign(:test_meta_datum, stub_model(TestMetaDatum,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Test/)
    rendered.should match(/Summary/)
    rendered.should match(/Test Url/)
    rendered.should match(/Page/)
    rendered.should match(/Location/)
    rendered.should match(/Browser/)
    rendered.should match(/Connectivity/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
  end
end
