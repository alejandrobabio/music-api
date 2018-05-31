class Musician < Artist
  validates :name, presence: true, uniqueness: true
end
