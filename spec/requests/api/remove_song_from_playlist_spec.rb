require 'request_helper'

module MusicAPI
  RSpec.describe Playlists::RemoveSong, type: :request do
    def app
      described_class
    end

    let(:header) { { 'Content-Type' => 'application/json' } }

    let(:playlist) { create :playlist }
    let(:song) { create :song }

    describe 'PUT /playlists/:id/remove_song' do
      it 'removes song from the playlist' do
        playlist.songs << song

        put "/playlists/#{playlist.id}/remove_song", { song_id: song.id }, header

        expect(last_response.status).to eq 204
        expect(song.reload).to be_a_kind_of Song
      end

      it 'remove playlist id from the song' do
        playlist.songs << song
        expect(song.playlist_ids).not_to be_empty
        expect(playlist.song_ids).not_to be_empty

        put "/playlists/#{playlist.id}/remove_song", { song_id: song.id }, header
        song.reload
        playlist.reload

        expect(song.playlist_ids).to be_empty
        expect(playlist.song_ids).to be_empty
      end

      it 'responds with an error if the song has not playlist' do
        put "/playlists/#{playlist.id}/remove_song", { song_id: song.id }, header

        expect(last_response.status).to eq 422
        expect(last_response.body).to match(
          /Song should belong to Playlist/
        )
      end
    end
  end
end
