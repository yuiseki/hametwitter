class CreatePrivs < ActiveRecord::Migration
  def self.up
    create_table :privs do |t|
      t.string :screen_name
      t.boolean :flag

      t.timestamps
    end
  end

  def self.down
    drop_table :privs
  end
end
