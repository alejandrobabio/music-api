class AddCoverPhotoDataToAlbums < ActiveRecord::Migration[5.0]
  def change
    add_column :albums, :cover_photo_data, :text
  end
end
