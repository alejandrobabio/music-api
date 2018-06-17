module MusicAPI
  class Playlists < Grape::API
    class Delete < Grape::API
      desc 'Delete a Playlist'

      route_param :id, type: Integer, desc: 'The Playlist id' do
        delete do
          UseCases::DeletePlaylist.new(Playlist).call(params[:id])
          body false
        end
      end
    end
  end
end
