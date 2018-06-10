require 'uploaders/image_uploader'

class Photo < ActiveRecord::Base
  include ImageUploader::Attachment.new(:image)

  belongs_to :song
end
