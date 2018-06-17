module MusicAPI
  class Bands < Grape::API
    class Create < Grape::API
      desc 'Create a new Band.'

      params do
        requires :name, type: String, desc: 'The name of the Band'
        optional :bio,  type: String, desc: 'Add biographical information'
      end

      post do
        present UseCases::CreateBand.new(Band).call(declared(params)),
          with: Entities::Band
      end
    end
  end
end
