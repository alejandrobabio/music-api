module MusicAPI
  module Entities
    class Band < Grape::Entity
      expose :id
      expose :name
      expose :bio
    end
  end
end
