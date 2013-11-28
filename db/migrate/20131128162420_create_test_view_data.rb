class CreateTestViewData < ActiveRecord::Migration
  def change
    create_table :test_view_data do |t|
      t.integer :load_time
      t.integer :first_byte
      t.integer :start_render
      t.integer :bytes_in
      t.integer :bytes_in_doc
      t.integer :requests
      t.integer :requests_doc
      t.integer :fully_loaded
      t.integer :doc_time
      t.integer :dom_elements
      t.integer :title_time

      t.timestamps
    end
  end
end
