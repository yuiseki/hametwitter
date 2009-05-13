class CreateFavs < ActiveRecord::Migration
  def self.up
    create_table :favs do |t|
      t.integer :status_id
      t.string :screen_name
      t.text :text

      t.timestamps
    end
  end

  def self.down
    drop_table :favs
  end
end
