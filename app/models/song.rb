class Song < ActiveRecord::Base
  belongs_to :album
  belongs_to :artist, polymorphic: true

  validates :name, presence: true, uniqueness: { scope: [:version, :artist] }
  validates :version, presence: true
  validates :artist, presence: true
end
