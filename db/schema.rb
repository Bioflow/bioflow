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

ActiveRecord::Schema.define(:version => 20130510230311) do

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "job_outputs", :force => true do |t|
    t.text     "work_output"
    t.string   "job_id"
    t.string   "widget_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "parentjob_widgetid"
  end

  create_table "jobs", :force => true do |t|
    t.string   "job_id"
    t.string   "work_obj"
    t.string   "input_ids"
    t.string   "output_ids"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.text     "jobContents"
    t.text     "notifications"
    t.string   "status"
    t.string   "jobname"
    t.integer  "user_id"
    t.boolean  "didexecute"
  end

  create_table "saved_jobs", :force => true do |t|
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "summary"
    t.integer  "totalinputs"
    t.integer  "totaloutputs"
    t.string   "parent"
    t.boolean  "isparent"
    t.string   "itemid"
    t.text     "workflowobjects"
    t.text     "connections"
    t.string   "name"
    t.string   "category"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "user_created_jobs", :force => true do |t|
    t.string   "job_id"
    t.string   "work_obj"
    t.string   "input_ids"
    t.string   "output_ids"
    t.text     "jobContents"
    t.text     "notifications"
    t.string   "status"
    t.string   "jobname"
    t.string   "user_id"
    t.string   "didexecute"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "summary"
    t.string   "itemid"
    t.text     "connections"
    t.text     "workflow_items"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "workflow_items", :force => true do |t|
    t.string   "name"
    t.string   "summary"
    t.integer  "totalinputs"
    t.integer  "totaloutputs"
    t.string   "category"
    t.boolean  "isparent"
    t.string   "parent"
    t.string   "itemid"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "commandline"
    t.text     "inputs"
    t.text     "outputs"
    t.text     "formparams"
    t.string   "command_format"
  end

end
