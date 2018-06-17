module MusicAPI
  class Albums < Grape::API
    class Create < Grape::API
      desc 'Create a new Album'

      params do
        requires :name, type: String, desc: 'Name of the Album'
        optional :cover_photo, type: File, desc: 'Cover Photo of the Album'
      end

      post do
        present UseCases::CreateAlbum.new(Album).call(declared(params)),
          with: Entities::Album
      end
    end
  end
end
