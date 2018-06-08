class Song < ActiveRecord::Base
  belongs_to :album
  belongs_to :artist, polymorphic: true
  has_many :play_list_songs
  has_many :play_lists, through: :play_list_songs

  validates :name, presence: true, uniqueness: { scope: [:version, :artist] }
  validates :version, presence: true
  validates :artist, presence: true
end
