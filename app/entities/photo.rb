module MusicAPI
  module Entities
    class Photo < Grape::Entity
      expose :id
      expose :title
      expose :image
    end
  end
end
