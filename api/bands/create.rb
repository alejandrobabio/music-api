module MusicAPI
  class Bands < Grape::API
    class Create < Grape::API
      desc 'Create a new Band.'

      params do
        requires :name, type: String
        optional :bio,  type: String
      end

      post do
        present UseCases::CreateBand.new(Band).call(declared(params)),
          with: Entities::Band
      end
    end
  end
end
