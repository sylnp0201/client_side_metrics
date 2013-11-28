require 'spec_helper'

describe "test_view_data/show" do
  before(:each) do
    @test_view_datum = assign(:test_view_datum, stub_model(TestViewDatum,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(/5/)
    rendered.should match(/6/)
    rendered.should match(/7/)
    rendered.should match(/8/)
    rendered.should match(/9/)
    rendered.should match(/10/)
    rendered.should match(/11/)
  end
end
