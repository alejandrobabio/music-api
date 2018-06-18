require 'request_helper'

module MusicAPI
  RSpec.describe Bands::Update, type: :request do
    def app
      described_class
    end

    let(:header) { { 'Content-Type' => 'application/json' } }

    let(:band) { create :band }

    describe 'PUT /bands/:id' do
      it 'returns updated status' do
        put "/bands/#{band.id}", { name: 'new name' }, header

        expect(last_response.status).to eq 204
      end

      it 'updates the band attributes' do
        new_attrs = {
          name: 'new name',
          bio: 'new bio'
        }
        put "/bands/#{band.id}", new_attrs, header
        band.reload

        expect(band.name).to eq 'new name'
        expect(band.bio).to eq 'new bio'
      end

      it 'allows add new albums' do
        file = File.open('spec/fixtures/images/genesis_foxtrot.jpg')
        new_albums = [
          {
            name: 'new album',
            cover_photo: Rack::Test::UploadedFile.new(file, 'image/png')
          }
        ]
        put "/bands/#{band.id}", { new_albums: new_albums },
          { 'Content-Type' => 'multipart/form-data' }

        expect(last_response.status).to eq 204
        expect(band.reload.albums.first.cover_photo.keys).to eq %i[original small thumbnail]
      end

      it 'allows remove album' do
        create_list :album, 2, artist: band
        expect(band.reload.albums.size).to eq 2

        input = { remove_album_ids: [ band.album_ids.first ] }
        put "/bands/#{band.id}", input, { 'Content-Type' => 'multipart/form-data' }
        band.reload

        expect(last_response.status).to eq 204
        expect(band.reload.albums.size).to eq 1
      end

      it 'raises an exeption on error' do
        put "/bands/#{band.id}", { name: '' }, header

        expect(last_response.status).to eq 422
        expect(last_response.body).to match(/Validation failed/)
      end
    end
  end
end
