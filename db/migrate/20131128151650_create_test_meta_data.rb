class CreateTestMetaData < ActiveRecord::Migration
  def change
    create_table :test_meta_data do |t|
      t.string :test_id
      t.string :summary
      t.string :test_url
      t.string :page
      t.string :location
      t.string :browser
      t.string :connectivity
      t.datetime :ran_at
      t.integer :runs
      t.integer :first_view_id
      t.integer :repeat_view_id

      t.timestamps
    end
  end
end
