module MusicAPI
  module Entities
    class Album < Grape::Entity
      expose :id
      expose :name
    end
  end
end
