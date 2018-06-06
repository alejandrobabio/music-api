require 'albums/create'
require 'albums/delete'
require 'albums/add_song'
require 'albums/remove_song'

module MusicAPI
  class Albums < Grape::API
    resources :albums do
      mount Create
      mount Delete
      mount AddSong
      mount RemoveSong
    end
  end
end
