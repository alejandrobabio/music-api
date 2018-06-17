module MusicAPI
  class Albums < Grape::API
    class Delete < Grape::API
      desc 'Delete an Album'

      route_param :id, type: Integer, desc: 'The Album id' do
        delete do
          UseCases::DeleteAlbum.new(Album).call(params[:id])
          body false
        end
      end
    end
  end
end
