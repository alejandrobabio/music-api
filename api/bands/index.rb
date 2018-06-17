module MusicAPI
  class Bands < Grape::API
    class Index < Grape::API
      desc 'List all Bands with Songs'

      get do
        present Band.all, with: Entities::BandWithSongs
      end
    end
  end
end

