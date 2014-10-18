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

ActiveRecord::Schema.define(version: 20141018201628) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "codeship_committers", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], :name => "index_codeship_committers_on_name"
  end

  create_table "codeship_projects", force: true do |t|
    t.integer  "codeship_project_uid"
    t.string   "repository_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["codeship_project_uid"], :name => "index_codeship_projects_on_codeship_project_uid"
  end

  create_table "codeship_builds", force: true do |t|
    t.string   "build_url"
    t.string   "commit_url"
    t.integer  "codeship_project_id"
    t.string   "status"
    t.string   "commit_sha"
    t.string   "short_commit_sha"
    t.text     "message"
    t.string   "branch"
    t.integer  "codeship_committer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["codeship_committer_id"], :name => "fk__codeship_builds_codeship_committer_id"
    t.index ["codeship_project_id"], :name => "index_codeship_builds_on_codeship_project_id"
    t.foreign_key ["codeship_committer_id"], "codeship_committers", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_codeship_builds_codeship_committer_id"
    t.foreign_key ["codeship_project_id"], "codeship_projects", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_codeship_builds_codeship_project_id"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string   "codeship_api_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["email"], :name => "index_users_on_email", :unique => true
    t.index ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  end

  create_table "codeship_project_relations", force: true do |t|
    t.integer  "user_id"
    t.integer  "codeship_project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["codeship_project_id"], :name => "index_codeship_project_relations_on_codeship_project_id"
    t.index ["user_id"], :name => "index_codeship_project_relations_on_user_id"
    t.foreign_key ["codeship_project_id"], "codeship_projects", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_codeship_project_relations_codeship_project_id"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_codeship_project_relations_user_id"
  end

end
