class Musician < Artist
  has_many :songs, foreign_key: 'artist_id'
  has_many :albums, foreign_key: 'artist_id'

  validates :name, presence: true, uniqueness: true
end
