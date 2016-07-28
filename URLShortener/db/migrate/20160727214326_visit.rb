class Visit < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :url_id, null: false
      t.integer :visitor_id, null: false
      t.timestamps
    end
    add_index :visits, :url_id 
    add_index :visits, :visitor_id
  end
end
