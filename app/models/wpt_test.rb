class WptTest < ActiveRecord::Base
  has_one :test_meta_datum, foreign_key: 'test_id'

  def self.unprocessed
    find_by_sql("SELECT wpt.* FROM wpt_tests AS wpt LEFT JOIN test_meta_data AS meta ON wpt.test_id = meta.test_id WHERE meta.test_id IS NULL")
  end

end
