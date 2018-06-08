class PlayList < ActiveRecord::Base
  has_many :play_list_songs
  has_many :songs, through: :play_list_songs

  validates :name, presence: true, uniqueness: true
end
