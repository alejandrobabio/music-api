module MusicAPI
  class Albums < Grape::API
    class Create < Grape::API
      desc 'Create a new Album'

      params do
        requires :name, type: String
      end

      post do
        present UseCases::CreateAlbum.new(Album).call(declared(params)),
          with: Entities::Album
      end
    end
  end
end
