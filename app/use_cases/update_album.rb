module MusicAPI
  module UseCases
    class UpdateAlbum
      attr_reader :model_class, :artist_class
      private :model_class, :artist_class

      def initialize(model_class, artist_class = nil)
        @model_class = model_class
        @artist_class = artist_class
      end

      def call(params)
        new_attrs = params.dup
        id = new_attrs.delete(:id)
        artist_id = new_attrs.delete(:artist_id)

        artist = artist_class.find(artist_id) if artist_id

        album = model_class.find(id)
        album.assign_attributes(new_attrs) unless new_attrs.empty?
        album.artist = artist if artist

        album.save!
      end
    end
  end
end
