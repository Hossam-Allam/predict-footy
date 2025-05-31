# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_05_31_234834) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "league_memberships", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "league_id", null: false
    t.integer "points", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["league_id"], name: "index_league_memberships_on_league_id"
    t.index ["user_id", "league_id"], name: "index_league_memberships_on_user_id_and_league_id", unique: true
    t.index ["user_id"], name: "index_league_memberships_on_user_id"
  end

  create_table "leagues", force: :cascade do |t|
    t.string "name"
    t.string "unique_code"
    t.bigint "owner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_leagues_on_owner_id"
    t.index ["unique_code"], name: "index_leagues_on_unique_code", unique: true
  end

  create_table "matches", force: :cascade do |t|
    t.integer "external_id"
    t.integer "season"
    t.integer "matchday"
    t.datetime "scheduled_at"
    t.string "home"
    t.string "away"
    t.integer "home_goals"
    t.integer "away_goals"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "home_crest"
    t.string "away_crest"
  end

  create_table "predictions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "match_id", null: false
    t.integer "home_score", default: 0
    t.integer "away_score", default: 0
    t.integer "points_awarded"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_predictions_on_match_id"
    t.index ["user_id", "match_id"], name: "index_predictions_on_user_id_and_match_id", unique: true
    t.index ["user_id"], name: "index_predictions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "league_memberships", "leagues"
  add_foreign_key "league_memberships", "users"
  add_foreign_key "leagues", "users", column: "owner_id"
  add_foreign_key "predictions", "matches"
  add_foreign_key "predictions", "users"
end
