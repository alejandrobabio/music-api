require 'request_helper'

module MusicAPI
  RSpec.describe Bands::Create, type: :request do
    def app
      described_class
    end

    let(:header) { { 'Content-Type' => 'application/json' } }

    describe 'POST /bands' do
      it 'returns created' do
        band_input = attributes_for :band
        post '/bands', band_input, header

        expect(last_response.status).to eq 201
        result = JSON.parse last_response.body
        expect(result['name']).to eq band_input[:name]
        expect(result['bio']).to eq band_input[:bio]
      end

      it 'creates a new band' do
        band_input = attributes_for :band

        expect {
          post '/bands', band_input, header
        }.to change(Band, :count).by(1)
      end

      it "can't create with an empty name"
    end
  end
end
