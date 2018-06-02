require 'request_helper'

module MusicAPI
  RSpec.describe Albums::Create, type: :request do
    def app
      described_class
    end

    let(:header) { { 'Content-Type' => 'application/json' } }

    describe 'POST /albums' do
      it 'returns created' do
        input = attributes_for :album
        post "/albums", input, header

        expect(last_response.status).to eq 201
        result = JSON.parse last_response.body
        expect(result['name']).to eq input[:name]
      end

      it "creates a new album" do
        input = attributes_for :album

        expect {
          post "/albums", input, header
        }.to change(Album, :count).by(1)
      end

      it "can't create with an empty name" do
        input = { name: nil }
        post "/albums", input, header

        expect(last_response.status).to eq 422
        expect(last_response.body).to match(/Validation failed/)
      end
    end
  end
end
