json.array!(@test_meta_data) do |test_meta_datum|
  json.extract! test_meta_datum, :test_id, :summary, :test_url, :page, :location, :browser, :connectivity, :ran_at, :runs, :first_view_id, :repeat_view_id
  json.url test_meta_datum_url(test_meta_datum, format: :json)
end
