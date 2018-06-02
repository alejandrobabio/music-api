class Album < ActiveRecord::Base
  belongs_to :artist, polymorphic: true

  validates :name, presence: true, uniqueness: true
end
