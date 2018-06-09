require_relative './shared/errors.rb'

module MusicAPI
  module UseCases
    class RemoveSongFromPlaylist
      attr_reader :song_class, :playlist_class
      private :song_class, :playlist_class

      def initialize(playlist_class, song_class)
        @playlist_class = playlist_class
        @song_class = song_class
      end

      def call(params)
        playlist = playlist_class.find(params[:id])
        song = song_class.find(params[:song_id])

        unless playlist.song_ids.include? song[:id]
          raise InconsistentData, 'Song should belong to Playlist'
        end

        playlist.songs.destroy(song)
      end
    end
  end
end
