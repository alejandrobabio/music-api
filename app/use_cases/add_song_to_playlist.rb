require_relative './shared/errors.rb'

module MusicAPI
  module UseCases
    class AddSongToPlaylist
      attr_reader :playlist_class, :song_class
      private :playlist_class, :song_class

      def initialize(playlist_class, song_class)
        @playlist_class = playlist_class
        @song_class = song_class
      end

      def call(params)
        playlist = playlist_class.find(params[:id])
        song = song_class.find(params[:song_id])

        playlist.songs << song
      end
    end
  end
end
