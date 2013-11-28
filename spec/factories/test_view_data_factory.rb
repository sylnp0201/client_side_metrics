FactoryGirl.define do
  factory :test_view_datum do
    load_time '12335'
    first_byte '1234'
    start_render '2345'
    bytes_in '1657905'
    bytes_in_doc '1057905'
    requests '1905'
    requests_doc '1005'
    fully_loaded '15005'
    doc_time '9005'
    dom_elements '3421'
    title_time '3000'
  end
end