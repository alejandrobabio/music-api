module MusicAPI
  class Playlists < Grape::API
    class AddSong < Grape::API
      desc 'Add a Song to a Playlist'

      params do
        requires :song_id, type: Integer
      end

      route_param :id, type: Integer do
        put 'add_song' do
          UseCases::AddSongToPlaylist.new(Playlist, Song).call(declared(params))
          body false
        end
      end
    end
  end
end
