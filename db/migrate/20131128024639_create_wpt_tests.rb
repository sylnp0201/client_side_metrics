class CreateWptTests < ActiveRecord::Migration
  def change
    create_table :wpt_tests do |t|
      t.string :test_id
      t.text :xml

      t.timestamps
    end
  end
end
