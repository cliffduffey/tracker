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

ActiveRecord::Schema.define(version: 20150415195605) do

  create_table "assets", force: true do |t|
    t.string   "asset_type"
    t.string   "host_name"
    t.string   "ip_address"
    t.string   "mac_address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "checklists", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vulnerabilities", force: true do |t|
    t.string   "status"
    t.string   "finding_details"
    t.text     "comments"
    t.string   "severity_override"
    t.text     "severity_justification"
    t.string   "vulnerability_number"
    t.string   "severity"
    t.string   "group_title"
    t.string   "rule_id"
    t.string   "rule_ver"
    t.string   "rule_title"
    t.text     "vuln_discussion"
    t.string   "ia_controls"
    t.text     "check_content"
    t.text     "fix_text"
    t.string   "cci_ref"
    t.integer  "checklist_id"
    t.integer  "asset_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "vulnerabilities", ["asset_id"], name: "index_vulnerabilities_on_asset_id"
  add_index "vulnerabilities", ["checklist_id"], name: "index_vulnerabilities_on_checklist_id"

end
