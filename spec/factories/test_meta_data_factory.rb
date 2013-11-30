FactoryGirl.define do
  factory :test_meta_datum do
    sequence(:test_id) { |n| n }
    sequence(:summary) { |n| "http://www.webpagetest.org/result/test_id_#{n}" }
    test_url 'http://www.bloomberg.com'
    page 'homepage'
    location 'Dulles'
    browser 'IE7'
    connectivity 'Cable'
    sequence(:ran_at) { |n| (5.day.ago + n.minutes) }
    runs '13'
  end
end