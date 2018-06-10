require 'uploaders/image_uploader'

class Album < ActiveRecord::Base
  include ImageUploader::Attachment.new(:cover_photo)

  belongs_to :artist, polymorphic: true
  has_many :songs, dependent: :nullify

  validates :name, presence: true, uniqueness: true
end
