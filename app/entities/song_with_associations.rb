require 'entities/band'
require 'entities/musician'
require 'entities/album'
require 'entities/photo'
require 'entities/song'

module MusicAPI
  module Entities
    class SongWithAssociations < Song
      expose :artist, as: :band, using: Band,
        if: ->(obj, opt) { obj.artist.type == 'Band' }
      expose :artist, as: :musician, using: Musician,
        if: ->(obj, opt) { obj.artist.type == 'Musician' }
      expose :album, using: Album, expose_nil: false
      expose :photos, using: Photo, expose_nil: false
    end
  end
end
