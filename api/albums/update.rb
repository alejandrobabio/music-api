module MusicAPI
  class Albums < Grape::API
    class Update < Grape::API
      helpers do
        def artist_class
          if params[:musician_id]
            Musician
          elsif params[:band_id]
            Band
          end
        end

        def formatted_params
          formatted_params = declared(params, include_missing: false)
          musician_id = formatted_params.delete(:musician_id)
          band_id = formatted_params.delete(:band_id)
          formatted_params.merge(artist_id: musician_id || band_id)
        end
      end

      desc 'Update an Album'

      params do
        optional :name, type: String
        optional :musician_id, type: Integer
        optional :band_id, type: Integer
        mutually_exclusive :band_id, :musician_id
        optional :cover_photo, type: File
      end

      route_param :id, type: Integer do
        put do
          UseCases::UpdateAlbum.new(Album, artist_class).call(formatted_params)
          body false
        end
      end
    end
  end
end
