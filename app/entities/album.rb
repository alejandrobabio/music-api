module MusicAPI
  module Entities
    class Album < Grape::Entity
      expose :id
      expose :name
      expose :cover_photo
    end
  end
end
