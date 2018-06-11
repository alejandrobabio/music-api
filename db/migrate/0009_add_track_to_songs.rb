class AddTrackToSongs < ActiveRecord::Migration[5.0]
  def change
    add_column :songs, :track_data, :text
  end
end
