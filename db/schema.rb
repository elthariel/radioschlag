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

ActiveRecord::Schema.define(:version => 20091203124429) do

  create_table "audio_file_styles", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.float    "metric"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "audio_file_types", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.float    "metric"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "audio_files", :force => true do |t|
    t.string   "path"
    t.integer  "audio_file_style_id"
    t.integer  "audio_file_type_id"
    t.integer  "duration"
    t.float    "metric"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "incoming_audio_files", :force => true do |t|
    t.string   "path"
    t.integer  "audio_file_type_id"
    t.integer  "audio_file_style_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
