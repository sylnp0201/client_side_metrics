FactoryGirl.define do
  factory :test_meta_datum do
    summary 'http://www.webpagetest.org/result/131128_8P_6843dd671b34179bc6bfb2b8983fa6c3/'
    test_url 'http://www.bloomberg.com'
    page 'homepage'
    location 'Dulles'
    browser 'IE7'
    connectivity 'Cable'
    ran_at '2013-11-28 03:04:39.000000'
    runs '13'
  end
end