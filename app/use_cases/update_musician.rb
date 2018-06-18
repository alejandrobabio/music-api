module MusicAPI
  module UseCases
    class UpdateMusician
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

        musician = model_class.find(id)
        musician.assign_attributes(new_attrs)
        musician.albums.build(new_albums)

        model_class.transaction do
          musician.albums.find(remove_album_ids).map(&:destroy) if remove_album_ids
          musician.save!
        end
      end
    end
  end
end
