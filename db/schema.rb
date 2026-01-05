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

ActiveRecord::Schema[8.0].define(version: 2026_01_05_034933) do
  create_table "escala_onibuses", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "onibus_id", null: false
    t.bigint "rota_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "motorista_id", null: false
    t.index ["motorista_id"], name: "index_escala_onibuses_on_motorista_id"
    t.index ["onibus_id"], name: "index_escala_onibuses_on_onibus_id"
    t.index ["rota_id"], name: "index_escala_onibuses_on_rota_id"
  end

  create_table "faculdades", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nome", null: false
    t.bigint "municipio_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["municipio_id"], name: "index_faculdades_on_municipio_id"
  end

  create_table "modelos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nome"
    t.string "fabricante"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "motoristas", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "cnh"
    t.string "categoria_cnh"
    t.date "validade_cnh"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_motoristas_on_user_id"
  end

  create_table "municipios", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nome", null: false
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "onibuses", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "terminal_origem"
    t.integer "numero_onibus"
    t.integer "capacidade_maxima"
    t.bigint "modelo_id", null: false
    t.index ["modelo_id"], name: "index_onibuses_on_modelo_id"
  end

  create_table "phones", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "number"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_phones_on_user_id"
  end

  create_table "roles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rota", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "municipio_origem_id", null: false
    t.bigint "municipio_destino_id", null: false
    t.time "horario_saida"
    t.time "horario_chegada"
    t.bigint "weekday_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["municipio_destino_id"], name: "index_rota_on_municipio_destino_id"
    t.index ["municipio_origem_id"], name: "index_rota_on_municipio_origem_id"
    t.index ["weekday_id"], name: "index_rota_on_weekday_id"
  end

  create_table "rota_trajetorias", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "rota_id", null: false
    t.json "geom"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rota_id"], name: "index_rota_trajetorias_on_rota_id"
  end

  create_table "schedules", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "weekday_id", null: false
    t.time "horario_saida", null: false
    t.time "horario_volta", null: false
    t.bigint "municipio_id", null: false
    t.bigint "faculdade_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["faculdade_id"], name: "index_schedules_on_faculdade_id"
    t.index ["municipio_id"], name: "index_schedules_on_municipio_id"
    t.index ["user_id"], name: "index_schedules_on_user_id"
    t.index ["weekday_id"], name: "index_schedules_on_weekday_id"
  end

  create_table "statuses", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_faculdades", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "faculdade_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["faculdade_id"], name: "index_user_faculdades_on_faculdade_id"
    t.index ["user_id"], name: "index_user_faculdades_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "nome", null: false
    t.string "cpf", null: false
    t.string "cep", null: false
    t.string "matricula"
    t.string "remember_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "status_id", null: false
    t.bigint "municipio_id", null: false
    t.bigint "role_id", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["municipio_id"], name: "index_users_on_municipio_id"
    t.index ["role_id"], name: "index_users_on_role_id"
    t.index ["status_id"], name: "index_users_on_status_id"
  end

  create_table "verifications", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "code_verification"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_verifications_on_user_id"
  end

  create_table "weekdays", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "escala_onibuses", "motoristas"
  add_foreign_key "escala_onibuses", "onibuses"
  add_foreign_key "escala_onibuses", "rota", column: "rota_id"
  add_foreign_key "faculdades", "municipios"
  add_foreign_key "motoristas", "users"
  add_foreign_key "onibuses", "modelos"
  add_foreign_key "phones", "users"
  add_foreign_key "rota", "municipios", column: "municipio_destino_id"
  add_foreign_key "rota", "municipios", column: "municipio_origem_id"
  add_foreign_key "rota", "weekdays"
  add_foreign_key "rota_trajetorias", "rota", column: "rota_id"
  add_foreign_key "schedules", "faculdades"
  add_foreign_key "schedules", "municipios"
  add_foreign_key "schedules", "users"
  add_foreign_key "schedules", "weekdays"
  add_foreign_key "user_faculdades", "faculdades"
  add_foreign_key "user_faculdades", "users"
  add_foreign_key "users", "municipios"
  add_foreign_key "users", "roles"
  add_foreign_key "users", "statuses"
end
