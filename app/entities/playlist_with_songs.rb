require 'entities/playlist'
require 'entities/song'

module MusicAPI
  module Entities
    class PlaylistWithSongs < Entities::Playlist
      expose :songs, using: Song
    end
  end
end
