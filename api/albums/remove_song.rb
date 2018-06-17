module MusicAPI
  class Albums < Grape::API
    class RemoveSong < Grape::API
      desc 'Remove a Song from an Album'

      params do
        requires :song_id, type: Integer, desc: 'The Song id to be removed'
      end

      route_param :id, type: Integer, desc: 'The Album id' do
        put 'remove_song' do
          UseCases::RemoveSongFromAlbum.new(Song).call(declared(params))
          body false
        end
      end
    end
  end
end
