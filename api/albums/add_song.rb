module MusicAPI
  class Albums < Grape::API
    class AddSong < Grape::API
      desc 'Add a Song to an Album'

      params do
        requires :song_id, type: Integer
      end

      route_param :id, type: Integer do
        put 'add_song' do
          UseCases::AddSongToAlbum.new(Album, Song).call(declared(params))
          body false
        end
      end
    end
  end
end
