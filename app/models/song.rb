class Song < ActiveRecord::Base
  belongs_to :album
  belongs_to :artist, polymorphic: true
  has_many :playlist_songs
  has_many :playlists, through: :playlist_songs
  has_many :photos

  validates :name, presence: true, uniqueness: { scope: [:version, :artist] }
  validates :version, presence: true
  validates :artist, presence: true
end
