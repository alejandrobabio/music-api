require_relative './shared/delete_artist.rb'

module MusicAPI
  module UseCases
    class DeleteBand
      include DeleteArtist
    end
  end
end
