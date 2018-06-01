require_relative './shared/create_artist.rb'

module MusicAPI
  module UseCases
    class CreateMusician
      include CreateArtist
    end
  end
end

