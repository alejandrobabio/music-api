require_relative './shared/create_artist.rb'

module MusicAPI
  module UseCases
    class CreateBand
      include CreateArtist
    end
  end
end
