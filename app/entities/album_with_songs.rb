require 'entities/album'
require 'entities/song'

module MusicAPI
  module Entities
    class AlbumWithSongs < Entities::Album
      expose :songs, using: Song
    end
  end
end
