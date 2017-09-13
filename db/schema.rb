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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170913175444) do

  create_table "actions", force: :cascade do |t|
    t.string "action_type"
  end

  create_table "events", force: :cascade do |t|
    t.string "action_type"
  end

  create_table "games", force: :cascade do |t|
    t.string "win_loss"
  end

  create_table "players", force: :cascade do |t|
    t.string  "name"
    t.integer "technical_skills"
    t.integer "soft_skills"
    t.integer "wellbeing"
    t.integer "game_id"
  end

  create_table "rounds", force: :cascade do |t|
    t.integer "game_id"
    t.integer "event_id"
  end

  create_table "turns", force: :cascade do |t|
    t.integer "player_id"
    t.integer "action_id"
  end

end
