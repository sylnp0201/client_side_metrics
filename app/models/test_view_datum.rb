class TestViewDatum < ActiveRecord::Base
  has_one :test_meta_datum, foreign_key: "first_view_id"
  has_one :test_meta_datum, foreign_key: "repeat_view_id"
end
