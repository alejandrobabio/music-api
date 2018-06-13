require 'request_helper'

module MusicAPI
  RSpec.describe Playlists::Update, type: :request do
    def app
      described_class
    end

    let(:header) { { 'Content-Type' => 'application/json' } }

    let(:playlist) { create :playlist }

    describe 'Put /playlists/:id' do
      it 'return created status' do
        put "/playlists/#{playlist.id}", { name: 'new name' }, header

        expect(last_response.status).to eq 204
      end

      it 'updates the playlist name' do
        put "/playlists/#{playlist.id}", { name: 'new name' }, header
        playlist.reload

        expect(playlist.name).to eq 'new name'
      end

      it 'raises an exeption on error' do
        put "/playlists/#{playlist.id}", { name: '' }, header

        expect(last_response.status).to eq 422
        expect(last_response.body).to match(/Validation failed/)
      end
    end
  end
end
