module MusicAPI
  class Musicians < Grape::API
    class Index < Grape::API
      desc 'List Musicians'

      get do
        present Musician.all, with: Entities::MusicianWithSongs
      end
    end
  end
end

