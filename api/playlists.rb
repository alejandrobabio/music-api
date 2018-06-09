require 'playlists/create'
require 'playlists/add_song'
require 'playlists/remove_song'

module MusicAPI
  class Playlists < Grape::API
    resources :playlists do
      mount Create
      mount AddSong
      mount RemoveSong
    end
  end
end
