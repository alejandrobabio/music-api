require 'albums/index'
require 'albums/create'
require 'albums/update'
require 'albums/delete'
require 'albums/add_song'
require 'albums/remove_song'

module MusicAPI
  class Albums < Grape::API
    resources :albums do
      mount Index
      mount Create
      mount Update
      mount Delete
      mount AddSong
      mount RemoveSong
    end
  end
end
