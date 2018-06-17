module MusicAPI
  class Musicians < Grape::API
    class Index < Grape::API
      desc 'List all Musicians with Songs'

      get do
        present Musician.all, with: Entities::MusicianWithSongs
      end
    end
  end
end

