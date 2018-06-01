module MusicAPI
  class Bands < Grape::API
    class Delete < Grape::API
      desc 'Delete a Band.'

      params do
        requires :id, type: Integer, desc: 'The Band id'
      end

      delete ':id' do
        UseCases::DeleteBand.new(Band).call(params[:id])
      end
    end
  end
end
