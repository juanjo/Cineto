# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121117113021) do

  create_table "torrents", :force => true do |t|
    t.integer  "torrent_id",                       :null => false
    t.datetime "added_at",                         :null => false
    t.boolean  "is_finished",   :default => false
    t.string   "name",                             :null => false
    t.decimal  "download_rate", :default => 0.0
    t.integer  "size",                             :null => false
    t.decimal  "percent_done",  :default => 0.0
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

end
