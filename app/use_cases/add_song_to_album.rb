require_relative './shared/errors.rb'

module MusicAPI
  module UseCases
    class AddSongToAlbum
      attr_reader :album_class, :song_class
      private :album_class, :song_class

      def initialize(album_class, song_class)
        @album_class = album_class
        @song_class = song_class
      end

      def call(params)
        album = album_class.find(params[:id])
        song = song_class.find(params[:song_id])

        if song[:album_id]
          raise InconsistentData, 'The Song already belongs to an Album'
        end

        album.songs << song
      end
    end
  end
end
