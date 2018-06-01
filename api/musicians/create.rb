module MusicAPI
  class Musicians < Grape::API
    class Create < Grape::API
      desc 'Create a new Musician.'

      params do
        requires :name, type: String
        optional :bio,  type: String
      end

      post do
        present Services::CreateArtist.new(Musician).call(declared(params)),
          with: Entities::Musician
      end
    end
  end
end
