# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090501075407) do

  create_table "favs", :force => true do |t|
    t.integer  "status_id"
    t.string   "screen_name"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "privates", :force => true do |t|
    t.string   "screen_name"
    t.boolean  "flag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "privs", :force => true do |t|
    t.string   "screen_name"
    t.boolean  "flag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statuses", :force => true do |t|
    t.integer  "status_id"
    t.string   "screen_name"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "twitter_yuiseki", :primary_key => "status_id", :force => true do |t|
    t.datetime "created_at"
    t.string   "screen_name", :limit => 32
    t.string   "text",        :limit => 192
  end

  add_index "twitter_yuiseki", ["status_id", "created_at", "screen_name", "text"], :name => "status_id"

end