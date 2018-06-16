require 'songs/index'
require 'songs/create'
require 'songs/play'
require 'songs/update'

module MusicAPI
  class Songs < Grape::API
    resources :songs do
      mount Index
      mount Create
      mount Play
      mount Update
    end
  end
end
