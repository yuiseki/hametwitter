class CreateStatuses < ActiveRecord::Migration
  def self.up
    create_table :statuses do |t|
      t.integer :status_id
      t.string :screen_name
      t.text :text

      t.timestamps
    end
  end

  def self.down
    drop_table :statuses
  end
end
