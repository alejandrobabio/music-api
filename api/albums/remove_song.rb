module MusicAPI
  class Albums < Grape::API
    class RemoveSong < Grape::API
      desc 'Remove a Song from an Album'

      params do
        requires :song_id, type: Integer
      end

      route_param :id, type: Integer do
        put 'remove_song' do
          UseCases::RemoveSongFromAlbum.new(Song).call(declared(params))
          body false
        end
      end
    end
  end
end
