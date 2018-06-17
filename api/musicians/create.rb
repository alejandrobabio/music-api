module MusicAPI
  class Musicians < Grape::API
    class Create < Grape::API
      desc 'Create a new Musician.'

      params do
        requires :name, type: String, desc: 'The name of the Musician'
        optional :bio,  type: String, desc: 'Add biographical information'
      end

      post do
        present UseCases::CreateMusician.new(Musician).call(declared(params)),
          with: Entities::Musician
      end
    end
  end
end
