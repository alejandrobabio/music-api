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
        expect(last_response.body).to eq({id: 1}.merge(band_input).to_json)
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
