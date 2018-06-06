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
        album = album_class.find(params[:album_id])
        song = song_class.find(params[:song_id])

        raise InconsistentData if song[:album_id]

        album.songs << song
      end
    end
  end
end
