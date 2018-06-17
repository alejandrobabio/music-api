module MusicAPI
  class Playlists < Grape::API
    class Create < Grape::API
      desc 'Create a new Playlist'

      params do
        requires :name, type: String, desc: 'Provide a name for the Playlist'
      end

      post do
        present UseCases::CreatePlaylist.new(Playlist).call(declared(params)),
          with: Entities::Playlist
      end
    end
  end
end
