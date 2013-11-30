class AddIndexToWptTestsAndMeta < ActiveRecord::Migration
  def change
    add_index(:wpt_tests, [:test_id], :unique => true)
    add_index(:test_meta_data, [:page, :ran_at, :location, :browser], :name => 'by_page_ran_at_location_browser')
  end
end
