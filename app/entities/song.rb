module MusicAPI
  module Entities
    class Song < Grape::Entity
      expose :id
      expose :name
      expose :duration
      expose :genre
      expose :version
      expose :track
    end
  end
end
