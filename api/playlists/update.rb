module MusicAPI
  class Playlists < Grape::API
    class Update < Grape::API
      desc 'Update a Playlist name'

      params do
        requires :name, type: String
      end

      route_param :id, type: Integer do
        put do
          UseCases::UpdatePlaylist.new(Playlist).call(declared(params))
          body false
        end
      end
    end
  end
end
