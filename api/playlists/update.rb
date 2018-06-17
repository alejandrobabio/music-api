module MusicAPI
  class Playlists < Grape::API
    class Update < Grape::API
      desc 'Update a Playlist name'

      params do
        requires :name, type: String, desc: 'The Playlist name'
      end

      route_param :id, type: Integer, desc: 'The Playlist id' do
        put do
          UseCases::UpdatePlaylist.new(Playlist).call(declared(params))
          body false
        end
      end
    end
  end
end
