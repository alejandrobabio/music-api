class AddTimestampsToArtistsAlbumsAndSongs < ActiveRecord::Migration[5.0]
  def change
    add_timestamps :artists, default: DateTime.now.utc
    change_column_default :artists, :created_at, nil
    change_column_default :artists, :updated_at, nil

    add_timestamps :albums, default: DateTime.now.utc
    change_column_default :albums, :created_at, nil
    change_column_default :albums, :updated_at, nil

    add_timestamps :songs, default: DateTime.now.utc
    change_column_default :songs, :created_at, nil
    change_column_default :songs, :updated_at, nil
  end
end
