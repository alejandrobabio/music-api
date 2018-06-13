require 'entities/musician'
require 'entities/song'

module MusicAPI
  module Entities
    class MusicianWithSongs < Musician
      expose :songs, using: Song
    end
  end
end
