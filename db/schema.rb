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

ActiveRecord::Schema.define(version: 2021_08_31_120341) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cinemas", force: :cascade do |t|
    t.integer "cinema_number"
    t.integer "total_seats"
    t.integer "columns"
    t.integer "rows"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cinema_number"], name: "index_cinemas_on_cinema_number", unique: true
  end

  create_table "movies", force: :cascade do |t|
    t.string "title", null: false
    t.integer "length", null: false
    t.text "description", null: false
    t.string "director", null: false
    t.string "genre", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "positions", force: :cascade do |t|
    t.bigint "seat_id", null: false
    t.bigint "reservation_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["reservation_id"], name: "index_positions_on_reservation_id"
    t.index ["seat_id"], name: "index_positions_on_seat_id"
  end

  create_table "redeemables", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "voucher_id"
    t.boolean "active", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_redeemables_on_user_id"
    t.index ["voucher_id"], name: "index_redeemables_on_voucher_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "screening_id"
    t.bigint "cinema_id"
    t.bigint "movie_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cinema_id"], name: "index_reservations_on_cinema_id"
    t.index ["movie_id"], name: "index_reservations_on_movie_id"
    t.index ["screening_id"], name: "index_reservations_on_screening_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "screenings", force: :cascade do |t|
    t.bigint "cinema_id"
    t.bigint "movie_id", null: false
    t.integer "additional_cost", default: 0
    t.datetime "airing_time", null: false
    t.integer "seats_available"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cinema_id"], name: "index_screenings_on_cinema_id"
    t.index ["movie_id"], name: "index_screenings_on_movie_id"
  end

  create_table "seats", force: :cascade do |t|
    t.string "seat_number", null: false
    t.bigint "cinema_id"
    t.string "seat_price", default: "0"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cinema_id"], name: "index_seats_on_cinema_id"
    t.index ["name"], name: "index_seats_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "email"
    t.json "tokens"
    t.string "first_name"
    t.string "last_name"
    t.integer "role", default: 0
    t.integer "points_earned", default: 0
    t.integer "points_redeemed", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  create_table "vouchers", force: :cascade do |t|
    t.string "code", null: false
    t.datetime "expiration_date", null: false
    t.integer "points_required", default: 0, null: false
    t.string "description"
    t.integer "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_vouchers_on_code", unique: true
  end

  add_foreign_key "screenings", "movies"
end
