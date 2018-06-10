module MusicAPI
  module Entities
    class Song < Grape::Entity
      expose :id
      expose :name
      expose :duration
      expose :genre
      expose :version
      expose :artist, as: :band, using: Band,
        if: ->(obj, opt) { obj.artist.type == 'Band' }
      expose :artist, as: :musician, using: Musician,
        if: ->(obj, opt) { obj.artist.type == 'Musician' }
      expose :album, using: Album, expose_nil: false
      expose :photos, using: Photo, expose_nil: false
    end
  end
end
