class CreateSongs < ActiveRecord::Migration[5.0]
  def change
    create_table :songs do |t|
      t.string :name
      t.integer :duration
      t.string :genre
      t.string :version
      t.references :album, foreign_key: true, index: true
      t.references :artist, polymorphic: true, index: true
    end
  end
end
