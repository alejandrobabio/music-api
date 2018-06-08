class Musician < Artist
  has_many :songs, as: :artist

  validates :name, presence: true, uniqueness: true
end
