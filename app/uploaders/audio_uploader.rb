require_relative '../../config/shrine_config'
require "image_processing/mini_magick"

class AudioUploader < Shrine
  ALLOWED_TYPES = %w[audio/mpeg audio/x-wav]

  plugin :pretty_location
  plugin :delete_raw
  plugin :delete_promoted
  plugin :validation_helpers

  Attacher.validate do
    validate_mime_type_inclusion(ALLOWED_TYPES)
  end
end
