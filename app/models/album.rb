class Album < ActiveRecord::Base
  belongs_to :artist, polymorphic: true
  has_many :songs, dependent: :nullify

  validates :name, presence: true, uniqueness: true
end
