class Band < Artist
  has_many :songs, as: :artist
  has_many :albums, as: :artist

  validates :name, presence: true, uniqueness: true
end
