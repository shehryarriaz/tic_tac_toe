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

ActiveRecord::Schema.define(:version => 20140904155231) do

  create_table "games", :force => true do |t|
    t.integer  "player_1_id"
    t.integer  "player_2_id"
    t.string   "status"
    t.integer  "winner_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "games", ["player_1_id"], :name => "index_games_on_player_1_id"
  add_index "games", ["player_2_id"], :name => "index_games_on_player_2_id"
  add_index "games", ["winner_id"], :name => "index_games_on_winner_id"

  create_table "moves", :force => true do |t|
    t.integer  "game_id"
    t.integer  "user_id"
    t.integer  "space"
    t.string   "marker"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "moves", ["game_id"], :name => "index_moves_on_game_id"
  add_index "moves", ["user_id"], :name => "index_moves_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "name"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "role"
  end

end
