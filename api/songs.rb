require 'songs/index'
require 'songs/create'
require 'songs/update'
require 'songs/delete'
require 'songs/play'

module MusicAPI
  class Songs < Grape::API
    resources :songs do
      mount Index
      mount Create
      mount Update
      mount Delete
      mount Play
    end
  end
end
