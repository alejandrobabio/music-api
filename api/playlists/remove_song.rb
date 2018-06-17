module MusicAPI
  class Playlists < Grape::API
    class RemoveSong < Grape::API
      desc 'Remove a Song from a Playlist'

      params do
        requires :song_id, type: Integer, desc: 'The Song id to be removed'
      end

      route_param :id, type: Integer, desc: 'The Playlist id' do
        put 'remove_song' do
          UseCases::RemoveSongFromPlaylist.new(Playlist, Song).call(declared(params))
          body false
        end
      end
    end
  end
end
