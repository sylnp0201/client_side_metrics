class TestMetaDatum < ActiveRecord::Base
  belongs_to :first_view, class_name: 'TestViewDatum'
  belongs_to :repeat_view, class_name: 'TestViewDatum'
  belongs_to :wpt_test, class_name: 'WptTest', foreign_key: 'test_id'
end
