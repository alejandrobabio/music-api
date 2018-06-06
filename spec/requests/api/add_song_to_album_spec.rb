require 'request_helper'

module MusicAPI
  RSpec.describe Albums::AddSong, type: :request do
    def app
      described_class
    end

    let(:header) { { 'Content-Type' => 'application/json' } }

    let(:song) { create :song }
    let(:album) { create :album }

    describe 'PUT /albums/:id/add_song' do
      it 'adds the song to the album' do
        put "/albums/#{album.id}/add_song", { song_id: song.id }, header

        expect(last_response.status).to eq 204
      end

      it 'stores album id in song' do
        put "/albums/#{album.id}/add_song", { song_id: song.id }, header
        song.reload

        expect(song.album_id).to eq album.id
      end

      it 'respond with error if the song has already an album' do
        song_with_album = create :song_with_album

        expect {
          put "/albums/#{album.id}/add_song",
            { song_id: song_with_album.id }, header
        }.to raise_exception(UseCases::InconsistentData)
      end
    end
  end
end
