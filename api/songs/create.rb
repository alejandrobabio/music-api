require 'params_validators/associate_artist_validator'

module MusicAPI
  class Songs < Grape::API
    class Create < Grape::API
      helpers do
        def artist_class
          params[:musician] ? Musician : Band
        end

        def formatted_params
          formatted_params = declared(params, include_missing: false)
          musician = formatted_params.delete(:musician)&.merge(type: 'Musician')
          band = formatted_params.delete(:band)&.merge(type: 'Band')
          formatted_params.merge(artist: musician || band)
        end
      end

      desc 'Create a new Song'
      params do
        requires :name, type: String, desc: 'The name of the song'
        requires :duration, type: Integer, desc: 'Duration in seconds'
        requires :genre, type: String, desc: 'Rock, Folk, Jazz, Pop ...'
        requires :version, type: String, desc: 'Unique identificator, e.g: "Single 1987"'
        optional :album, type: Hash do
          optional :id, type: Integer, desc: 'Provide for an existing Album'
          optional :name, type: String, desc: 'Only informed for a new Album'
          exactly_one_of :id, :name
        end
        optional :musician, associate_artist: true, type: Hash do
          optional :id, type: Integer, desc: 'Provide for an existing Musician'
          optional :name, type: String, desc: 'Only informed for a new Musician'
          optional :bio, type: String, desc: 'Add biographical information'
        end
        optional :band, associate_artist: true, type: Hash do
          optional :id, type: Integer, desc: 'Provide for an existing Band'
          optional :name, type: String, desc: 'Only informed for a new Band'
          optional :bio, type: String, desc: 'Add biographical information'
        end
        exactly_one_of :musician, :band
        optional :photos, type: Array do
          optional :title, type: String, desc: 'Provide the photo Title'
          optional :image, type: File, desc: 'Provide the photo file'
        end
        optional :track, type: File, desc: 'Upload the audio file of this song'
      end

      post do
        present UseCases::CreateSong.new(Song, artist_class, Album)
          .call(formatted_params), with: Entities::SongWithAssociations
      end
    end
  end
end
