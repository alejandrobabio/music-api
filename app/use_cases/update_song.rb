require_relative './shared/errors.rb'

module MusicAPI
  module UseCases
    class UpdateSong
      attr_reader :model_class, :artist_class, :album_class
      private :model_class, :artist_class, :album_class

      def initialize(model_class, artist_class, album_class)
        @model_class = model_class
        @artist_class = artist_class
        @album_class = album_class
      end

      def call(attrs)
        song_attrs, id, artist_id, album_id, new_photos, remove_photo_ids =
          split_attrs(attrs)

        song = model_class.find(id)
        song.assign_attributes(song_attrs)
        song.artist = artist_class.find(artist_id) if artist_id
        song.album = album_class.find(album_id) if album_id

        if song.album && song.album[:artist_id] != song.artist[:id]
          raise InconsistentData, "Song's Album does not belongs to the Song's Artist"
        end

        song.photos.build(new_photos) if new_photos

        model_class.transaction do
          song.photos.find(remove_photo_ids).map(&:destroy) if remove_photo_ids
          song.save!
        end
      end

      private

      def split_attrs(attrs)
        song_attrs = attrs.dup
        id = song_attrs.delete(:id)
        artist_id = song_attrs.delete(:artist_id)
        album_id = song_attrs.delete(:album_id)
        new_photos = song_attrs.delete(:new_photos)
        remove_photo_ids = song_attrs.delete(:remove_photo_ids)

        [song_attrs, id, artist_id, album_id, new_photos, remove_photo_ids]
      end
    end
  end
end
