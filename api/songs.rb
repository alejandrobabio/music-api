require 'songs/create'

module MusicAPI
  class Songs < Grape::API
    resources :songs do
      mount Create
    end
  end
end
