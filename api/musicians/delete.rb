module MusicAPI
  class Musicians < Grape::API
    class Delete < Grape::API
      desc 'Delete a Band.'

      params do
        requires :id, type: Integer, desc: 'The Band id'
      end

      delete ':id' do
        UseCases::DeleteMusician.new(Musician).call(params[:id])
      end
    end
  end
end
