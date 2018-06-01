require_relative './shared/delete_artist.rb'

module MusicAPI
  module UseCases
    class DeleteMusician
      include DeleteArtist
    end
  end
end
