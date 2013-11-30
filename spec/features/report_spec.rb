require 'spec_helper'

describe "report", js: true do
  before do
    meta = FactoryGirl.build(:test_meta_datum)
    first_view = FactoryGirl.create(:test_view_datum, {load_time: 123})
    repeat_view = FactoryGirl.create(:test_view_datum, {load_time: 234})
    meta.first_view = first_view
    meta.repeat_view = repeat_view
    meta.save!
  end

  it "displays report chart" do
    visit '/?browser=IE7&fields=first_byte,title_time'
    expect(page).to have_content 'Bloomberg.com Beta Site Page Load Performance'
    expect(page).to have_content 'first_byte'
    expect(page).to have_content 'title_time'
    expect(page).to have_content 'Browser: IE7'
    click_button 'IE7'
    click_link 'IE8'
    expect(page).to have_content 'Browser: IE8'
    expect(page).to have_content 'first_byte'
    expect(page).to have_content 'title_time'
  end

  it "displays most recent 24-hours summary table" do
    visit '/'
    expect(page).to have_content 'Last 24-hour'
  end
end