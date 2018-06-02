module MusicAPI
  class Albums < Grape::API
    class Delete < Grape::API
      desc 'Delete an Album'

      params do
        requires :id, type: Integer, desc: 'The Album id'
      end

      delete ':id' do
        UseCases::DeleteAlbum.new(Album).call(params[:id])
      end
    end
  end
end
