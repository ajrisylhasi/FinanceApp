# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_17_005829) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "akcizas", force: :cascade do |t|
    t.string "lloji"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "articles", force: :cascade do |t|
    t.string "pershkrimi"
    t.integer "tarif_kodi", limit: 8
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "njesia"
    t.string "kodi"
    t.text "pershkrimi_gjate"
    t.float "dogana"
    t.string "lloji_akcizes"
    t.float "akciza"
    t.float "tvsh"
    t.string "kategoria"
  end

  create_table "autorizim_articles", force: :cascade do |t|
    t.integer "article_id"
    t.integer "autorizim_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "max"
    t.index ["article_id"], name: "index_autorizim_articles_on_article_id"
    t.index ["autorizim_id"], name: "index_autorizim_articles_on_autorizim_id"
  end

  create_table "autorizim_products", force: :cascade do |t|
    t.integer "autorizim_id"
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["autorizim_id"], name: "index_autorizim_products_on_autorizim_id"
    t.index ["product_id"], name: "index_autorizim_products_on_product_id"
  end

  create_table "autorizims", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "data_leshimit"
    t.date "data_skadimit"
    t.string "shteti"
    t.string "qyteti"
    t.string "adresa"
    t.float "max"
  end

  create_table "clients", force: :cascade do |t|
    t.string "kompania"
    t.string "shteti"
    t.string "qyteti"
    t.string "adresa"
    t.string "numri_tel"
    t.string "numri_fiskal"
    t.string "numri_biz"
    t.string "numri_tvsh"
    t.string "konsignacioni"
    t.string "shteti_k"
    t.string "qyteti_k"
    t.string "adresa_k"
    t.string "numri_tel_k"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "pack_category"
    t.integer "term"
    t.string "email"
    t.float "vat"
  end

  create_table "destinims", force: :cascade do |t|
    t.string "kodi"
    t.string "pershkrimi"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "doganas", force: :cascade do |t|
    t.string "kodi"
    t.string "pershkrimi"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "explande_articles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "import_id"
    t.integer "import_article_id"
    t.integer "exportlande_id"
    t.float "sasia"
    t.string "emertimi"
    t.integer "article_id"
    t.float "pesha"
    t.float "qmimi"
    t.float "vat"
    t.index ["article_id"], name: "index_explande_articles_on_article_id"
    t.index ["exportlande_id"], name: "index_explande_articles_on_exportlande_id"
    t.index ["import_article_id"], name: "index_explande_articles_on_import_article_id"
    t.index ["import_id"], name: "index_explande_articles_on_import_id"
  end

  create_table "export_gjendjas", force: :cascade do |t|
    t.integer "export_id"
    t.float "sasia"
    t.string "pershkrimi"
    t.integer "export_product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "normative_article_id"
    t.float "mbetja"
    t.float "pesha"
    t.float "mbetja_peshe"
    t.string "kodi"
    t.float "qmimi"
    t.float "mbetja_qmimi"
    t.index ["export_id"], name: "index_export_gjendjas_on_export_id"
    t.index ["export_product_id"], name: "index_export_gjendjas_on_export_product_id"
    t.index ["normative_article_id"], name: "index_export_gjendjas_on_normative_article_id"
  end

  create_table "export_products", force: :cascade do |t|
    t.integer "export_id"
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sasia"
    t.integer "normative_id"
    t.float "qmimi"
    t.float "vat"
    t.index ["export_id"], name: "index_export_products_on_export_id"
    t.index ["normative_id"], name: "index_export_products_on_normative_id"
    t.index ["product_id"], name: "index_export_products_on_product_id"
  end

  create_table "exportlandes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nr_exportit"
    t.integer "client_id"
    t.date "data"
    t.index ["client_id"], name: "index_exportlandes_on_client_id"
  end

  create_table "exports", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nr_exportit"
    t.text "gjendja_hash"
    t.integer "client_id"
    t.text "pack_gjendja"
    t.text "pack_not"
    t.integer "ndryshimi"
    t.date "data"
    t.text "note"
    t.index ["client_id"], name: "index_exports_on_client_id"
  end

  create_table "faturas", force: :cascade do |t|
    t.string "nr_fatures"
    t.date "data"
    t.integer "export_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "note"
    t.integer "edit"
    t.string "default"
    t.integer "exportlande_id"
    t.index ["export_id"], name: "index_faturas_on_export_id"
    t.index ["exportlande_id"], name: "index_faturas_on_exportlande_id"
  end

  create_table "fees", force: :cascade do |t|
    t.string "pershkrimi"
    t.float "sasia"
    t.float "pesha"
    t.float "qmimi"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "fatura_id"
    t.float "pesha_neto"
    t.index ["fatura_id"], name: "index_fees_on_fatura_id"
  end

  create_table "garancion_gjendjas", force: :cascade do |t|
    t.integer "garancion_id"
    t.integer "import_gjendja_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "vlera"
    t.index ["garancion_id"], name: "index_garancion_gjendjas_on_garancion_id"
    t.index ["import_gjendja_id"], name: "index_garancion_gjendjas_on_import_gjendja_id"
  end

  create_table "garancions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "identifikimi"
    t.float "vlera"
    t.date "data"
    t.date "data_skadimit"
    t.string "pershkrimi"
    t.float "vlera_t"
  end

  create_table "import_articles", force: :cascade do |t|
    t.integer "import_id"
    t.integer "article_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "sasia"
    t.string "emertimi"
    t.float "pesha"
    t.float "qmimi"
    t.float "qmimi_tot"
    t.float "transport"
    t.float "pesha_njesi"
    t.float "qmimi_njesi"
    t.float "qmimi_kg"
    t.float "dogana"
    t.float "taksa_dogana"
    t.string "lloji_akcizes"
    t.float "akciza"
    t.float "tvsh"
    t.float "taksa_tvsh"
    t.float "gjithsej_taksa"
    t.float "taksa_akciza"
    t.string "njesia"
    t.string "kodi"
    t.index ["article_id"], name: "index_import_articles_on_article_id"
    t.index ["import_id"], name: "index_import_articles_on_import_id"
  end

  create_table "import_gjendjas", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "sasia"
    t.string "emertimi"
    t.string "pershkrimi"
    t.integer "import_id"
    t.integer "import_article_id"
    t.float "pesha"
    t.string "kodi"
    t.float "qmimi"
    t.index ["import_article_id"], name: "index_import_gjendjas_on_import_article_id"
    t.index ["import_id"], name: "index_import_gjendjas_on_import_id"
  end

  create_table "imports", force: :cascade do |t|
    t.string "nr_dud"
    t.date "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "transporti"
    t.text "gjendja_hash"
    t.string "nr_fatures"
    t.integer "client_id"
    t.integer "mbyllja_id"
    t.boolean "mbylled"
    t.string "kodi_doganor"
    t.string "zyra_doganore"
    t.string "kodi_destinim"
    t.string "zyra_destinim"
    t.string "dogana"
    t.string "destinimi"
    t.index ["client_id"], name: "index_imports_on_client_id"
    t.index ["mbyllja_id"], name: "index_imports_on_mbyllja_id"
  end

  create_table "kompanis", force: :cascade do |t|
    t.string "numri_fiskal"
    t.string "numri_biznesit"
    t.string "numri_tvsh"
    t.string "kompania"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.string "shteti"
    t.string "qyteti"
    t.string "adresa"
    t.string "zip"
    t.string "numri_identifikues"
    t.string "bank_account"
    t.string "bank"
    t.string "account_holder"
    t.string "corresponding_bank"
    t.string "swift_code"
  end

  create_table "lists", force: :cascade do |t|
    t.integer "product_packet_id"
    t.integer "packing_list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "packet_id"
    t.integer "sasia"
    t.index ["packet_id"], name: "index_lists_on_packet_id"
    t.index ["packing_list_id"], name: "index_lists_on_packing_list_id"
    t.index ["product_packet_id"], name: "index_lists_on_product_packet_id"
  end

  create_table "mbylljas", force: :cascade do |t|
    t.string "nr_mbylljes"
    t.date "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "njesis", force: :cascade do |t|
    t.string "lloji"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "normative_articles", force: :cascade do |t|
    t.integer "normative_id"
    t.integer "article_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "sasia"
    t.float "mbetja"
    t.string "njesia"
    t.float "pesha_bruto"
    t.float "mbetja_peshe"
    t.float "qmimi"
    t.string "pesha_qmimi"
    t.float "mbetja_qmimi"
    t.index ["article_id"], name: "index_normative_articles_on_article_id"
    t.index ["normative_id"], name: "index_normative_articles_on_normative_id"
  end

  create_table "normatives", force: :cascade do |t|
    t.integer "nr_normatives"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_id"
    t.date "data"
    t.text "attachment"
    t.string "kategoria"
    t.index ["product_id"], name: "index_normatives_on_product_id"
  end

  create_table "packets", force: :cascade do |t|
    t.string "nr_paketes"
    t.string "dimensioni"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "packing_lists", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "export_id"
    t.text "pack_gjendja"
    t.integer "ndryshimi"
    t.index ["export_id"], name: "index_packing_lists_on_export_id"
  end

  create_table "palet_packets", force: :cascade do |t|
    t.integer "palet_id"
    t.integer "packet_id"
    t.integer "sasia"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["packet_id"], name: "index_palet_packets_on_packet_id"
    t.index ["palet_id"], name: "index_palet_packets_on_palet_id"
  end

  create_table "palet_products", force: :cascade do |t|
    t.integer "palet_id"
    t.integer "product_id"
    t.integer "sasia"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["palet_id"], name: "index_palet_products_on_palet_id"
    t.index ["product_id"], name: "index_palet_products_on_product_id"
  end

  create_table "palets", force: :cascade do |t|
    t.string "nr_paletes"
    t.string "dimensioni"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_packets", force: :cascade do |t|
    t.integer "product_id"
    t.integer "packet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sasia"
    t.index ["packet_id"], name: "index_product_packets_on_packet_id"
    t.index ["product_id"], name: "index_product_packets_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "pershkrimi"
    t.integer "tarif_kodi", limit: 8
    t.float "qmimi"
    t.string "kodi"
    t.string "articlenr"
  end

  create_table "sub_mbylljas", force: :cascade do |t|
    t.integer "sub_id"
    t.integer "mbyllja_id"
    t.string "emertimi"
    t.integer "article_id"
    t.float "pesha"
    t.float "sasia"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "qmimi"
    t.index ["article_id"], name: "index_sub_mbylljas_on_article_id"
    t.index ["mbyllja_id"], name: "index_sub_mbylljas_on_mbyllja_id"
    t.index ["sub_id"], name: "index_sub_mbylljas_on_sub_id"
  end

  create_table "subexpls", force: :cascade do |t|
    t.integer "import_id"
    t.integer "exportlande_id"
    t.integer "import_gjendja_id"
    t.float "sasia"
    t.float "pesha"
    t.float "qmimi"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "explande_article_id"
    t.index ["explande_article_id"], name: "index_subexpls_on_explande_article_id"
    t.index ["exportlande_id"], name: "index_subexpls_on_exportlande_id"
    t.index ["import_gjendja_id"], name: "index_subexpls_on_import_gjendja_id"
    t.index ["import_id"], name: "index_subexpls_on_import_id"
  end

  create_table "subs", force: :cascade do |t|
    t.integer "import_id"
    t.integer "export_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "article_name"
    t.integer "import_gjendja_id"
    t.integer "export_gjendja_id"
    t.float "sasia"
    t.float "mbetja"
    t.float "pesha"
    t.float "mbetja_peshe"
    t.float "qmimi"
    t.float "mbetja_qmimi"
    t.float "mbetja_real"
    t.float "mbetja_qmimi_real"
    t.float "mbetja_pesha_real"
    t.index ["export_gjendja_id"], name: "index_subs_on_export_gjendja_id"
    t.index ["export_id"], name: "index_subs_on_export_id"
    t.index ["import_gjendja_id"], name: "index_subs_on_import_gjendja_id"
    t.index ["import_id"], name: "index_subs_on_import_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "kategoria"
    t.integer "data_auto"
    t.integer "data_gar"
    t.string "email"
    t.string "tel_number"
    t.string "first_name"
    t.string "last_name"
    t.string "username"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "autorizim_articles", "articles"
  add_foreign_key "autorizim_articles", "autorizims"
  add_foreign_key "autorizim_products", "autorizims"
  add_foreign_key "autorizim_products", "products"
  add_foreign_key "explande_articles", "articles"
  add_foreign_key "explande_articles", "exportlandes"
  add_foreign_key "explande_articles", "import_articles"
  add_foreign_key "explande_articles", "imports"
  add_foreign_key "export_gjendjas", "export_products"
  add_foreign_key "export_gjendjas", "exports"
  add_foreign_key "export_gjendjas", "normative_articles"
  add_foreign_key "export_products", "exports"
  add_foreign_key "export_products", "normatives"
  add_foreign_key "export_products", "products"
  add_foreign_key "exportlandes", "clients"
  add_foreign_key "exports", "clients"
  add_foreign_key "faturas", "exportlandes"
  add_foreign_key "faturas", "exports"
  add_foreign_key "fees", "faturas"
  add_foreign_key "garancion_gjendjas", "garancions"
  add_foreign_key "garancion_gjendjas", "import_gjendjas"
  add_foreign_key "import_articles", "articles"
  add_foreign_key "import_articles", "imports"
  add_foreign_key "import_gjendjas", "import_articles"
  add_foreign_key "import_gjendjas", "imports"
  add_foreign_key "imports", "clients"
  add_foreign_key "imports", "mbylljas"
  add_foreign_key "lists", "packets"
  add_foreign_key "lists", "packing_lists"
  add_foreign_key "lists", "product_packets"
  add_foreign_key "normative_articles", "articles"
  add_foreign_key "normative_articles", "normatives"
  add_foreign_key "normatives", "products"
  add_foreign_key "packing_lists", "exports"
  add_foreign_key "palet_packets", "packets"
  add_foreign_key "palet_packets", "palets"
  add_foreign_key "palet_products", "palets"
  add_foreign_key "palet_products", "products"
  add_foreign_key "product_packets", "packets"
  add_foreign_key "product_packets", "products"
  add_foreign_key "sub_mbylljas", "articles"
  add_foreign_key "sub_mbylljas", "mbylljas"
  add_foreign_key "sub_mbylljas", "subs"
  add_foreign_key "subexpls", "explande_articles"
  add_foreign_key "subexpls", "exportlandes"
  add_foreign_key "subexpls", "import_gjendjas"
  add_foreign_key "subexpls", "imports"
  add_foreign_key "subs", "export_gjendjas"
  add_foreign_key "subs", "exports"
  add_foreign_key "subs", "import_gjendjas"
  add_foreign_key "subs", "imports"
end
