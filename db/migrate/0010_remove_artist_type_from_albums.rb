class RemoveArtistTypeFromAlbums < ActiveRecord::Migration[5.0]
  def up
    remove_index :albums, [:artist_type, :artist_id]
    remove_column :albums, :artist_type
    add_index :albums, :artist_id
  end

  def down
    remove_index :albums, :artist_id
    add_column :albums, :artist_type, :string
    add_index :albums, [:artist_type, :artist_id]
  end
end
