require 'params_validators/associate_artist_validator'

module MusicAPI
  class Songs < Grape::API
    class Create < Grape::API
      helpers do
        def artist_class
          params[:musician] ? Musician : Band
        end

        def formated_params
          formated_params = declared(params, include_missing: false)
          musician = formated_params.delete(:musician)&.merge(type: 'Musician')
          band = formated_params.delete(:band)&.merge(type: 'Band')
          formated_params.merge(artist: musician || band)
        end
      end

      desc 'Create a new Song'
      params do
        requires :name, type: String
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
          optional :bio
        end
        optional :band, associate_artist: true, type: Hash do
          optional :id, type: Integer, desc: 'Provide for an existing Band'
          optional :name, type: String, desc: 'Only informed for a new Band'
          optional :bio
        end
        exactly_one_of :musician, :band
      end

      post do
        present UseCases::CreateSong.new(Song, artist_class, Album)
          .call(formated_params), with: Entities::Song
      end
    end
  end
end
