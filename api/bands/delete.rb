module MusicAPI
  class Bands < Grape::API
    class Delete < Grape::API
      desc 'Delete a Band.'

      route_param :id, type: Integer, desc: 'The Band id' do
        delete do
          UseCases::DeleteBand.new(Band).call(params[:id])
          body false
        end
      end
    end
  end
end
