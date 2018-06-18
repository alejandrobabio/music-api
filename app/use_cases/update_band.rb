module MusicAPI
  module UseCases
    class UpdateBand
      attr_reader :model_class
      private :model_class

      def initialize(model_class)
        @model_class = model_class
      end

      def call(attrs)
        new_attrs = attrs.dup
        id = new_attrs.delete(:id)
        new_albums = new_attrs.delete(:new_albums)
        remove_album_ids = new_attrs.delete(:remove_album_ids)

        band = model_class.find(id)
        band.assign_attributes(new_attrs)
        band.albums.build(new_albums)

        model_class.transaction do
          band.albums.find(remove_album_ids).map(&:destroy)
          band.save!
        end
      end
    end
  end
end
