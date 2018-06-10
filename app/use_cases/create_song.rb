require_relative './shared/errors.rb'

module MusicAPI
  module UseCases
    class CreateSong
      attr_reader :model_class, :artist_class, :album_class
      private :model_class, :artist_class, :album_class

      def initialize(model_class, artist_class, album_class)
        @model_class = model_class
        @artist_class = artist_class
        @album_class = album_class
      end

      def call(attrs)
        song_attrs = attrs.dup
        artist_attrs = song_attrs.delete(:artist)
        album_attrs = song_attrs.delete(:album)
        photos_attrs = song_attrs.delete(:photos)

        model_class.transaction do
          artist =
            if artist_attrs[:id]
              artist_class.find(artist_attrs[:id])
            else
              artist_class.create!(artist_attrs)
            end

          album =
            if album_attrs
              if album_attrs[:id]
                album_class.find(album_attrs[:id])
              else
                album_class.create!(album_attrs.merge(artist: artist))
              end
            end

          if album && album[:artist_id] != artist[:id]
            raise InconsistentData, "Song's Album does not belongs to the Song's Artist"
          end

          song = model_class.create!(song_attrs.merge(artist: artist, album: album))
          song.photos.create!(photos_attrs) if photos_attrs
          song
        end
      end
    end
  end
end
