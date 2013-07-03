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

ActiveRecord::Schema.define(:version => 20130629235734) do

  create_table "feeds", :force => true do |t|
    t.integer  "user_id",                                        :null => false
    t.string   "title"
    t.text     "description"
    t.string   "url"
    t.string   "site_url"
    t.datetime "last_modified_at"
    t.string   "status",             :limit => 8
    t.integer  "posts_count",                     :default => 0
    t.integer  "unread_posts_count",              :default => 0
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

  add_index "feeds", ["user_id", "last_modified_at"], :name => "index_feeds_on_user_id_and_last_modified_at"
  add_index "feeds", ["user_id", "url"], :name => "index_feeds_on_user_id_and_url"
  add_index "feeds", ["user_id"], :name => "index_feeds_on_user_id"

  create_table "pg_search_documents", :force => true do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "posts", :force => true do |t|
    t.integer  "feed_id",                         :null => false
    t.string   "title"
    t.string   "author"
    t.text     "url"
    t.text     "content"
    t.datetime "published_at"
    t.datetime "read_at"
    t.datetime "created_at"
    t.boolean  "bookmarked",   :default => false
  end

  add_index "posts", ["feed_id", "url"], :name => "index_posts_on_feed_id_and_url"
  add_index "posts", ["feed_id"], :name => "index_posts_on_feed_id"
  add_index "posts", ["published_at"], :name => "index_posts_on_published_at"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "perishable_token"
    t.string   "api_token"
    t.boolean  "enabled"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
