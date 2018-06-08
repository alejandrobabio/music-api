require 'playlists/create'

module MusicAPI
  class Playlists < Grape::API
    resources :playlists do
      mount Create
    end
  end
end
