module MusicAPI
  class Playlists < Grape::API
    class Index < Grape::API
      desc 'List all Playlists with songs'

      get do
        present Playlist.all, with: Entities::PlaylistWithSongs
      end
    end
  end
end
