require 'request_helper'

module MusicAPI
  RSpec.describe Playlists::Create, type: :request do
    def app
      described_class
    end

    let(:header) { { 'Content-Type' => 'application/json' } }

    describe 'POST /playlists' do
      it 'returns created' do
        input = attributes_for :playlist
        post "/playlists", input, header

        expect(last_response.status).to eq 201
        result = JSON.parse last_response.body
        expect(result['name']).to eq input[:name]
      end

      it "creates a new playlist" do
        input = attributes_for :playlist

        expect {
          post "/playlists", input, header
        }.to change(Playlist, :count).by(1)
      end

      it "can't create with an empty name" do
        input = { name: nil }
        post "/playlists", input, header

        expect(last_response.status).to eq 422
        expect(last_response.body).to match(/Validation failed/)
      end
    end
  end
end
