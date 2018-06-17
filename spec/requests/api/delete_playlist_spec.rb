require 'request_helper'

module MusicAPI
  RSpec.describe Playlists::Delete, type: :request do
    def app
      described_class
    end

    let(:header) { { 'Content-Type' => 'application/json' } }
    let!(:playlist) { create :playlist }

    describe "DELETE /playlists/:id" do
      it 'returns 204 status' do
        delete "/playlists/#{playlist.id}", header

        expect(last_response.status).to eq 204
      end

      it "deletes the playlist" do
        expect {
          delete "/playlists/#{playlist.id}", header
        }.to change(Playlist, :count).by(-1)
      end

      it "can't delete if it does not exists" do
        delete "/playlists/99999", header

        expect(last_response.status).to eq 404
      end
    end
  end
end
