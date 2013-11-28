json.array!(@test_view_data) do |test_view_datum|
  json.extract! test_view_datum, :load_time, :first_byte, :start_render, :bytes_in, :bytes_in_doc, :requests, :requests_doc, :fully_loaded, :doc_time, :dom_elements, :title_time
  json.url test_view_datum_url(test_view_datum, format: :json)
end
