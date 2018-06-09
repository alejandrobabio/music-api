class PlaylistSong < ActiveRecord::Base
  belongs_to :song
  belongs_to :playlist

  validates :playlist_id, presence: true, uniqueness: { scope: :song_id }
  validates :song_id, presence: true, uniqueness: { scope: :playlist_id }
end
