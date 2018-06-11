require 'songs/create'
require 'songs/play'

module MusicAPI
  class Songs < Grape::API
    resources :songs do
      mount Create
      mount Play
    end
  end
end
