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

ActiveRecord::Schema.define(version: 20171202175120) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.jsonb "content"
    t.integer "student_id"
    t.bigint "exam_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content"], name: "index_answers_on_content", using: :gin
    t.index ["exam_id"], name: "index_answers_on_exam_id"
    t.index ["student_id"], name: "index_answers_on_student_id"
  end

  create_table "documents", force: :cascade do |t|
    t.string "name"
    t.string "content"
    t.bigint "subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id"], name: "index_documents_on_subject_id"
  end

  create_table "exams", force: :cascade do |t|
    t.string "title"
    t.integer "status", default: 0
    t.bigint "subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "questions"
    t.integer "duration"
    t.index ["questions"], name: "index_exams_on_questions", using: :gin
    t.index ["subject_id"], name: "index_exams_on_subject_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "middle_name"
    t.integer "age"
    t.string "gender"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "subject_enrolleds", force: :cascade do |t|
    t.integer "student_id"
    t.bigint "subject_id"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_subject_enrolleds_on_student_id"
    t.index ["subject_id"], name: "index_subject_enrolleds_on_subject_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "instructor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["instructor_id"], name: "index_subjects_on_instructor_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "answers", "exams"
  add_foreign_key "answers", "users", column: "student_id"
  add_foreign_key "documents", "subjects"
  add_foreign_key "exams", "subjects"
  add_foreign_key "subject_enrolleds", "users", column: "student_id"
  add_foreign_key "subjects", "users", column: "instructor_id"
end
