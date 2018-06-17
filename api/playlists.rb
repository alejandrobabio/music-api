require 'playlists/index'
require 'playlists/create'
require 'playlists/update'
require 'playlists/delete'
require 'playlists/add_song'
require 'playlists/remove_song'

module MusicAPI
  class Playlists < Grape::API
    resources :playlists do
      mount Index
      mount Create
      mount Update
      mount Delete
      mount AddSong
      mount RemoveSong
    end
  end
end
