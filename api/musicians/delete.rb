module MusicAPI
  class Musicians < Grape::API
    class Delete < Grape::API
      desc 'Delete a Musician.'

      route_param :id, type: Integer, desc: 'The Musician id' do
        delete do
          UseCases::DeleteMusician.new(Musician).call(params[:id])
          body false
        end
      end
    end
  end
end
