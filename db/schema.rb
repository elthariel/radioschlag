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

ActiveRecord::Schema.define(:version => 20100709160552) do

  create_table "audio_file_assignments", :force => true do |t|
    t.integer  "playlist_id"
    t.integer  "audio_file_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.integer  "user_id"
  end

  create_table "ftp_accounts", :force => true do |t|
    t.integer "user_id"
    t.integer "quota"
    t.integer "sessions", :default => 3
  end

  create_table "incoming_audio_files", :force => true do |t|
    t.string   "path"
    t.integer  "audio_file_type_id"
    t.integer  "audio_file_style_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "playlist_players", :force => true do |t|
    t.string "name"
    t.text   "desc"
  end

  create_table "playlist_types", :force => true do |t|
    t.string "name"
    t.text   "desc"
  end

  create_table "playlists", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.integer  "playlist_type_id"
    t.integer  "playlist_player_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",            :default => 1, :null => false
  end

  create_table "program_assignments", :force => true do |t|
    t.integer "user_id"
    t.integer "program_id"
  end

  create_table "programs", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "playlist_id", :default => 1, :null => false
  end

  create_table "role_assignments", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  create_table "roles", :force => true do |t|
    t.string "name"
    t.text   "desc"
  end

  create_table "slots", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.integer  "start"
    t.integer  "end"
    t.integer  "program_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "allow_live", :default => false
  end

  create_table "type_style_assignments", :force => true do |t|
    t.integer  "audio_file_type_id"
    t.integer  "audio_file_style_id"
    t.integer  "playlist_id"
    t.float    "metric",              :default => 1.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "phone"
    t.text     "profile"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ftp_account_id",    :default => 0
  end

end
