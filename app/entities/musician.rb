module MusicAPI
  module Entities
    class Musician < Grape::Entity
      expose :id
      expose :name
      expose :bio
    end
  end
end
