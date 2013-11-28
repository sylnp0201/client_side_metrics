json.array!(@wpt_tests) do |wpt_test|
  json.extract! wpt_test, :test_id, :xml
  json.url wpt_test_url(wpt_test, format: :json)
end
