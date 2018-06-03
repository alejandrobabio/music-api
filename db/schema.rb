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

ActiveRecord::Schema.define(version: 3) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "artist_type"
    t.integer "artist_id"
    t.index ["artist_type", "artist_id"], name: "index_albums_on_artist_type_and_artist_id"
  end

  create_table "artists", id: :serial, force: :cascade do |t|
    t.string "type"
    t.string "name"
    t.text "bio"
    t.index ["type", "id"], name: "index_artists_on_type_and_id"
  end

  create_table "songs", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "duration"
    t.string "genre"
    t.string "version"
    t.integer "album_id"
    t.string "artist_type"
    t.integer "artist_id"
    t.index ["album_id"], name: "index_songs_on_album_id"
    t.index ["artist_type", "artist_id"], name: "index_songs_on_artist_type_and_artist_id"
  end

  add_foreign_key "songs", "albums"
end
