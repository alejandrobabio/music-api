class Band < Artist
  validates :name, presence: true, uniqueness: true
end
