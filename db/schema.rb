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

ActiveRecord::Schema[8.0].define(version: 2026_08_24_110000) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "league_memberships", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "league_id", null: false
    t.integer "points", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "season"
    t.index ["league_id"], name: "index_league_memberships_on_league_id"
    t.index ["user_id", "league_id", "season"], name: "index_lm_on_user_league_season", unique: true
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
    t.index ["status"], name: "index_matches_on_status"
  end

  create_table "mobile_auth_handoffs", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "token_digest", null: false
    t.datetime "expires_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expires_at"], name: "index_mobile_auth_handoffs_on_expires_at"
    t.index ["token_digest"], name: "index_mobile_auth_handoffs_on_token_digest", unique: true
    t.index ["user_id"], name: "index_mobile_auth_handoffs_on_user_id"
  end

  create_table "predictions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "match_id", null: false
    t.integer "home_score", default: 0
    t.integer "away_score", default: 0
    t.integer "points_awarded"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "season"
    t.index ["match_id"], name: "index_predictions_on_match_id"
    t.index ["user_id", "match_id"], name: "index_predictions_on_user_id_and_match_id", unique: true
  end

  create_table "table_prediction_entries", force: :cascade do |t|
    t.bigint "table_prediction_id", null: false
    t.bigint "team_id", null: false
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["table_prediction_id", "position"], name: "idx_on_table_prediction_id_position_8bcfb31890", unique: true
    t.index ["table_prediction_id", "team_id"], name: "idx_on_table_prediction_id_team_id_a3be4495fc", unique: true
    t.index ["table_prediction_id"], name: "index_table_prediction_entries_on_table_prediction_id"
    t.index ["team_id"], name: "index_table_prediction_entries_on_team_id"
  end

  create_table "table_predictions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "season", default: 2026, null: false
    t.integer "points"
    t.datetime "evaluated_at"
    t.index ["user_id", "season"], name: "index_table_predictions_on_user_id_and_season", unique: true
    t.index ["user_id"], name: "index_table_predictions_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "crest_url"
    t.index ["name"], name: "index_teams_on_name", unique: true
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
    t.string "remember_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["remember_token"], name: "index_users_on_remember_token"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "league_memberships", "leagues"
  add_foreign_key "league_memberships", "users"
  add_foreign_key "leagues", "users", column: "owner_id"
  add_foreign_key "mobile_auth_handoffs", "users"
  add_foreign_key "predictions", "matches"
  add_foreign_key "predictions", "users"
  add_foreign_key "table_prediction_entries", "table_predictions"
  add_foreign_key "table_prediction_entries", "teams"
  add_foreign_key "table_predictions", "users"
end
