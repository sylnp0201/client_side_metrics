require 'spec_helper'

describe "report", js: true do
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
end