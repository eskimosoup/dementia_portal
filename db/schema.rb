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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150727100221) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "article_categories", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "article_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "article_categories", ["article_id"], name: "index_article_categories_on_article_id", using: :btree
  add_index "article_categories", ["category_id"], name: "index_article_categories_on_category_id", using: :btree

  create_table "articles", force: :cascade do |t|
    t.string   "title",                        null: false
    t.date     "date"
    t.text     "summary"
    t.string   "image"
    t.text     "content"
    t.string   "slug"
    t.string   "suggested_url"
    t.boolean  "display",       default: true
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "title",                          null: false
    t.string   "slug"
    t.string   "suggested_url"
    t.string   "image"
    t.boolean  "display",         default: true
    t.boolean  "display_on_home", default: true
    t.integer  "position",        default: 0
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "categories", ["slug"], name: "index_categories_on_slug", using: :btree

  create_table "frequently_asked_question_categories", force: :cascade do |t|
    t.integer  "frequently_asked_question_id"
    t.integer  "category_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "frequently_asked_question_categories", ["category_id"], name: "index_frequently_asked_question_categories_on_category_id", using: :btree
  add_index "frequently_asked_question_categories", ["frequently_asked_question_id"], name: "faq_categories_on_faq_id", using: :btree

  create_table "frequently_asked_questions", force: :cascade do |t|
    t.string   "question",                  null: false
    t.text     "answer",                    null: false
    t.boolean  "display",    default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "optimadmin_administrators", force: :cascade do |t|
    t.string   "username",               null: false
    t.string   "email",                  null: false
    t.string   "role",                   null: false
    t.string   "auth_token"
    t.string   "password_digest",        null: false
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "optimadmin_administrators", ["auth_token"], name: "index_optimadmin_administrators_on_auth_token", using: :btree
  add_index "optimadmin_administrators", ["email"], name: "index_optimadmin_administrators_on_email", using: :btree
  add_index "optimadmin_administrators", ["username"], name: "index_optimadmin_administrators_on_username", using: :btree

  create_table "optimadmin_documents", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "document",    null: false
    t.string   "module_name"
    t.integer  "module_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "optimadmin_external_links", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "optimadmin_images", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "image",       null: false
    t.string   "module_name"
    t.integer  "module_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "optimadmin_links", force: :cascade do |t|
    t.string   "menu_resource_type"
    t.integer  "menu_resource_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "optimadmin_menu_item_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
  end

  add_index "optimadmin_menu_item_hierarchies", ["ancestor_id", "descendant_id", "generations"], name: "menu_item_anc_desc_idx", unique: true, using: :btree
  add_index "optimadmin_menu_item_hierarchies", ["descendant_id"], name: "menu_item_desc_idx", using: :btree

  create_table "optimadmin_menu_items", force: :cascade do |t|
    t.string   "menu_name",       limit: 100
    t.string   "name",            limit: 100
    t.integer  "parent_id"
    t.boolean  "deletable",                   default: true
    t.boolean  "new_window",                  default: false
    t.string   "title_attribute", limit: 100
    t.integer  "position",                    default: 0
    t.integer  "link_id"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "optimadmin_menu_items", ["link_id"], name: "index_optimadmin_menu_items_on_link_id", using: :btree

  create_table "optimadmin_module_pages", force: :cascade do |t|
    t.string   "name"
    t.string   "route"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "optimadmin_site_settings", force: :cascade do |t|
    t.string "key"
    t.string "value"
    t.string "environment"
  end

  create_table "organisations", force: :cascade do |t|
    t.string   "name",                             null: false
    t.text     "address"
    t.string   "postcode",                         null: false
    t.string   "organisation_type"
    t.string   "phone"
    t.string   "email"
    t.string   "website"
    t.boolean  "display",           default: true
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "pages", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.string   "image"
    t.boolean  "display",       default: true
    t.string   "slug"
    t.string   "suggested_url"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "resource_categories", force: :cascade do |t|
    t.integer  "resource_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "resource_categories", ["category_id"], name: "index_resource_categories_on_category_id", using: :btree
  add_index "resource_categories", ["resource_id"], name: "index_resource_categories_on_resource_id", using: :btree

  create_table "resource_services", force: :cascade do |t|
    t.integer  "resource_id"
    t.integer  "service_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "resource_services", ["resource_id"], name: "index_resource_services_on_resource_id", using: :btree
  add_index "resource_services", ["service_id"], name: "index_resource_services_on_service_id", using: :btree

  create_table "resource_target_groups", force: :cascade do |t|
    t.integer  "resource_id"
    t.integer  "target_group_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "resource_target_groups", ["resource_id"], name: "index_resource_target_groups_on_resource_id", using: :btree
  add_index "resource_target_groups", ["target_group_id"], name: "index_resource_target_groups_on_target_group_id", using: :btree

  create_table "resources", force: :cascade do |t|
    t.string   "name",                              null: false
    t.text     "summary"
    t.text     "description"
    t.string   "url"
    t.text     "youtube_embed_code"
    t.integer  "organisation_id"
    t.string   "date"
    t.string   "time"
    t.text     "venue"
    t.string   "postcode"
    t.string   "slug"
    t.string   "suggested_url"
    t.boolean  "display",            default: true
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.text     "address"
    t.string   "main_phone"
    t.string   "secondary_phone"
  end

  add_index "resources", ["organisation_id"], name: "index_resources_on_organisation_id", using: :btree

  create_table "services", force: :cascade do |t|
    t.string   "name",                      null: false
    t.boolean  "display",    default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "target_groups", force: :cascade do |t|
    t.string   "name",                         null: false
    t.boolean  "display",       default: true
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "slug"
    t.string   "suggested_url"
  end

  add_foreign_key "article_categories", "articles"
  add_foreign_key "article_categories", "categories"
  add_foreign_key "frequently_asked_question_categories", "categories"
  add_foreign_key "frequently_asked_question_categories", "frequently_asked_questions"
  add_foreign_key "resource_categories", "categories"
  add_foreign_key "resource_categories", "resources"
  add_foreign_key "resource_services", "resources"
  add_foreign_key "resource_services", "services"
  add_foreign_key "resource_target_groups", "resources"
  add_foreign_key "resource_target_groups", "target_groups"
  add_foreign_key "resources", "organisations"
end
