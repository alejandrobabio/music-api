class RemoveArtistTypeFromSongs < ActiveRecord::Migration[5.0]
  def up
    remove_index :songs, [:artist_type, :artist_id]
    remove_column :songs, :artist_type
    add_index :songs, :artist_id
  end

  def down
    remove_index :songs, :artist_id
    add_column :songs, :artist_type, :string
    add_index :songs, [:artist_type, :artist_id]
  end
end
