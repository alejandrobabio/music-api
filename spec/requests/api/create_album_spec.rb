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
        file = File.open('spec/fixtures/images/genesis_foxtrot.jpg')
        input.merge!(cover_photo: Rack::Test::UploadedFile.new(file, 'image/png'))
        post "/albums", input, { 'Content-Type' => 'multipart/form-data' }

        expect(last_response.status).to eq 201
        result = JSON.parse last_response.body
        expect(result['name']).to eq input[:name]
        expect(result['cover_photo']['metadata']['filename']).to eq 'genesis_foxtrot.jpg'
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
