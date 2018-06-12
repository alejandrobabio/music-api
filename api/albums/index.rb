module MusicAPI
  class Albums < Grape::API
    class Index < Grape::API
      desc 'List Albums'

      get do
        present Album.all, with: Entities::AlbumWithSongs
      end
    end
  end
end
