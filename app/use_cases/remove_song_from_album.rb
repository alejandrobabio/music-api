require_relative './shared/errors.rb'

module MusicAPI
  module UseCases
    class RemoveSongFromAlbum
      attr_reader :song_class
      private :song_class

      def initialize(song_class)
        @song_class = song_class
      end

      def call(params)
        song = song_class.find(params[:song_id])

        unless song[:album_id] && song[:album_id] == params[:id]
          raise InconsistentData, 'Song should belong to Album'
        end

        song.update(album_id: nil)
      end
    end
  end
end
