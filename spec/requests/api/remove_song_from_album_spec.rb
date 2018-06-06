require 'request_helper'

module MusicAPI
  RSpec.describe Albums::RemoveSong, type: :request do
    def app
      described_class
    end

    let(:header) { { 'Content-Type' => 'application/json' } }

    let(:song) { create :song_with_album }

    describe 'PUT /albums/:id/remove_song' do
      it 'removes song from the album' do
        put "/albums/#{song.album_id}/remove_song", { song_id: song.id }, header

        expect(last_response.status).to eq 204
      end

      it 'remove album id from the song' do
        expect(song.album_id).not_to be_nil

        put "/albums/#{song.album_id}/remove_song", { song_id: song.id }, header
        song.reload

        expect(song.album_id).to be_nil
      end

      it 'responds with an error if the song has not album' do
        song_without_album = create :song

        put "/albums/111/remove_song",
          { song_id: song_without_album.id }, header

        expect(last_response.status).to eq 422
        expect(last_response.body).to match(
          /Song should belong to Album/
        )
      end

      it 'responds with an error if the song has another album' do
        put "/albums/#{song.album_id + 1}/remove_song",
          { song_id: song.id }, header

        expect(last_response.status).to eq 422
        expect(last_response.body).to match(
          /Song should belong to Album/
        )
      end
    end
  end
end
