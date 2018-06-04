module MusicAPI
  module UseCases
    InconsistentData = Class.new(StandardError)

    class CreateSong
      attr_reader :model_class, :artist_class, :album_class
      private :model_class, :artist_class, :album_class

      def initialize(model_class, artist_class, album_class)
        @model_class = model_class
        @artist_class = artist_class
        @album_class = album_class
      end

      def call(attrs)
        song_attrs = attrs[:song].dup
        artist_attrs = song_attrs.delete(:artist)
        album_attrs = song_attrs.delete(:album)

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

          raise InconsistentData if album && album[:artist_id] != artist[:id]

          model_class.create!(song_attrs.merge(artist: artist, album: album))
        end
      end
    end
  end
end
