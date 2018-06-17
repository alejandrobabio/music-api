require 'uploaders/audio_uploader'

class Song < ActiveRecord::Base
  include AudioUploader::Attachment.new(:track)

  belongs_to :album
  belongs_to :artist
  has_many :playlist_songs
  has_many :playlists, through: :playlist_songs
  has_many :photos

  validates :name, presence: true, uniqueness: { scope: [:version, :artist] }
  validates :version, presence: true
  validates :artist, presence: true
end
