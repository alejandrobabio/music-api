module MusicAPI
  class Songs < Grape::API
    class Index < Grape::API
      desc 'List all Songs'

      get do
        present Song.all, with: Entities::SongWithAssociations
      end
    end
  end
end
