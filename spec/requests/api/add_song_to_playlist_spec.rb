require 'request_helper'

module MusicAPI
  RSpec.describe Playlists::AddSong, type: :request do
    def app
      described_class
    end

    let(:header) { { 'Content-Type' => 'application/json' } }

    let(:song) { create :song }
    let(:playlist) { create :playlist }

    describe 'PUT /playlists/:id/add_song' do
      it 'adds the song to the playlist' do
        put "/playlists/#{playlist.id}/add_song", { song_id: song.id }, header

        expect(last_response.status).to eq 204
      end

      it 'set playlist id in songs playlist_ids' do
        expect(song.playlist_ids).to be_empty

        put "/playlists/#{playlist.id}/add_song", { song_id: song.id }, header
        song.reload

        expect(song.playlist_ids).to include playlist.id
      end

      it 'responds with error if the song already belongs to the playlist' do
        playlist.songs << song

        put "/playlists/#{playlist.id}/add_song",
            { song_id: song.id }, header

        expect(last_response.status).to eq 422
        expect(last_response.body).to match(/Validation failed/)
      end
    end
  end
end
