module MusicAPI
  class Songs < Grape::API
    class Delete < Grape::API
      desc 'Delete a Song'

      route_param :id, type: Integer, desc: 'The Song id' do
        delete do
          UseCases::DeleteSong.new(Song).call(params[:id])
          body false
        end
      end
    end
  end
end
