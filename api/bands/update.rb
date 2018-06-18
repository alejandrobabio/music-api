module MusicAPI
  class Bands < Grape::API
    class Update < Grape::API
      desc 'Update a Band'
      params do
        optional :name, type: String, desc: 'The name of the Band'
        optional :bio,  type: String, desc: 'Add biographical information'
        optional :new_albums, type: Array do
          optional :name, type: String, desc: 'Name of the Album'
          optional :cover_photo, type: File, desc: 'Cover Photo of the Album'
        end
        optional :remove_album_ids, type: Array[Integer],
          desc: 'Provide the ids of the Albums to be removed from this band'
      end

      route_param :id, type: Integer, desc: 'The Band id' do
        put do
          UseCases::UpdateBand.new(Band)
            .call(declared(params, include_missing: false))
          body false
        end
      end
    end
  end
end
