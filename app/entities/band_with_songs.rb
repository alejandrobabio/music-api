require 'entities/band'
require 'entities/song'

module MusicAPI
  module Entities
    class BandWithSongs < Band
      expose :songs, using: Song
    end
  end
end
