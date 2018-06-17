module MusicAPI
  class Songs < Grape::API
    class Update < Grape::API
      helpers do
        def artist_class
          params[:musician_id] ? Musician : Band
        end

        def formatted_params
          formatted_params = declared(params, include_missing: false)
          musician_id = formatted_params.delete(:musician_id)
          band_id = formatted_params.delete(:band_id)
          formatted_params.merge(artist_id: musician_id || band_id)
        end
      end

      desc 'Update a Song'
      params do
        optional :name, type: String, desc: 'The name of the song'
        optional :duration, type: Integer, desc: 'Duration in seconds'
        optional :genre, type: String, desc: 'Rock, Folk, Jazz, Pop ...'
        optional :version, type: String, desc: 'Unique identificator, e.g: "Single 1987"'
        optional :album_id, type: Integer, desc: 'Change the Album giving its id'
        optional :musician_id, type: Integer, desc: 'Provide the Id for change to an existing Musician'
        optional :band_id, type: Integer, desc: 'Provide the Id for change to an existing Band'
        mutually_exclusive :musician_id, :band_id
        optional :new_photos, type: Array do
          optional :title, type: String, desc: 'Provide the photo Title'
          optional :image, type: File, desc: 'Provide the photo file'
        end
        optional :remove_photo_ids, type: Array[Integer],
          desc: 'Provide the ids of the Photos to be removed'
        optional :track, type: File, desc: 'Change the audio file of this song'
      end

      route_param :id, type: Integer, desc: 'The Song id' do
        put do
          UseCases::UpdateSong.new(Song, artist_class, Album)
            .call(formatted_params)
          body false
        end
      end
    end
  end
end
