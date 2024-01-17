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

ActiveRecord::Schema[7.0].define(version: 2024_01_17_124201) do
  create_table "active_storage_attachments", charset: "utf8mb4", collation: "utf8mb4_0900_bin", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8mb4", collation: "utf8mb4_0900_bin", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "utf8mb4", collation: "utf8mb4_0900_bin", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "contacts", charset: "utf8mb4", collation: "utf8mb4_0900_bin", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "title"
    t.text "content"
    t.text "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contributors", charset: "utf8mb4", collation: "utf8mb4_0900_bin", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.text "self_introduction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "club_name1"
    t.string "club_name2"
    t.string "club_name3"
    t.string "club_name4"
    t.string "club_name5"
    t.index ["user_id"], name: "index_contributors_on_user_id"
  end

  create_table "information", charset: "utf8mb4", collation: "utf8mb4_0900_bin", force: :cascade do |t|
    t.string "title"
    t.string "public_or_private"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", charset: "utf8mb4", collation: "utf8mb4_0900_bin", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "post_id", null: false
    t.integer "number_of_orders"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "payment_status"
    t.integer "results"
    t.index ["post_id"], name: "index_orders_on_post_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "posts", charset: "utf8mb4", collation: "utf8mb4_0900_bin", force: :cascade do |t|
    t.bigint "contributor_id", null: false
    t.string "title"
    t.date "event_date"
    t.string "venue"
    t.time "event_start_time"
    t.time "event_end_time"
    t.datetime "posting_start_time"
    t.datetime "posting_end_time"
    t.string "address"
    t.integer "recruitment_numbers"
    t.text "content"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category"
    t.string "instagram_url"
    t.string "line_url"
    t.string "facebook_url"
    t.string "youtube_url"
    t.string "note_url"
    t.string "x_url"
    t.string "club_name"
    t.index ["contributor_id"], name: "index_posts_on_contributor_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_bin", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "sex"
    t.date "birthday"
    t.integer "usertype"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "contributors", "users"
  add_foreign_key "orders", "posts"
  add_foreign_key "orders", "users"
  add_foreign_key "posts", "contributors"
end
