# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 29) do

  create_table "authors", :force => true do |t|
    t.datetime "created_at",                                    :null => false
    t.datetime "modified_at",                                   :null => false
    t.string   "email"
    t.string   "hashed_pass", :limit => 40
    t.string   "name",        :limit => 100
    t.string   "url"
    t.boolean  "is_active",                  :default => false
  end

  create_table "blacklist", :force => true do |t|
    t.string   "item"
    t.datetime "created_at", :null => false
  end

  create_table "comments", :force => true do |t|
    t.integer  "post_id"
    t.string   "name"
    t.string   "email"
    t.string   "url"
    t.string   "subject"
    t.string   "synd_title"
    t.text     "body"
    t.text     "body_raw"
    t.text     "body_searchable"
    t.string   "ip"
    t.boolean  "is_approved",     :default => false
    t.datetime "created_at",                         :null => false
    t.datetime "modified_at",                        :null => false
  end

  create_table "pages", :force => true do |t|
    t.string   "permalink",   :limit => 128
    t.text     "body_raw"
    t.text     "body"
    t.boolean  "is_active",                  :default => true
    t.datetime "created_at"
    t.datetime "modified_at"
    t.string   "text_filter"
    t.string   "title",       :limit => 128
  end

  create_table "posts", :force => true do |t|
    t.integer  "author_id",                          :default => 0,    :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "modified_at",                                          :null => false
    t.string   "permalink",           :limit => 128
    t.string   "title"
    t.string   "synd_title"
    t.text     "summary"
    t.text     "body_raw"
    t.text     "extended_raw"
    t.text     "body"
    t.text     "extended"
    t.boolean  "is_active",                          :default => true
    t.string   "custom_field_1"
    t.string   "custom_field_2"
    t.string   "custom_field_3"
    t.text     "body_searchable"
    t.text     "extended_searchable"
    t.string   "text_filter"
    t.integer  "comment_status",                     :default => 0
  end

  create_table "preferences", :force => true do |t|
    t.string "nice_name",   :null => false
    t.text   "description", :null => false
    t.string "name",        :null => false
    t.string "value",       :null => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id"
    t.text     "data"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at"
  end

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "updates", :force => true do |t|
    t.datetime "last_checked_at"
    t.boolean  "update_available", :default => false
    t.string   "update_version"
  end

end
