module MusicAPI
  module Entities
    class Playlist < Grape::Entity
      expose :id
      expose :name
    end
  end
end
