require 'request_helper'

module MusicAPI
  RSpec.describe Musicians::Update, type: :request do
    def app
      described_class
    end

    let(:header) { { 'Content-Type' => 'application/json' } }

    let(:musician) { create :musician }

    describe 'PUT /musicians/:id' do
      it 'returns updated status' do
        put "/musicians/#{musician.id}", { name: 'new name' }, header

        expect(last_response.status).to eq 204
      end

      it 'updates the musician attributes' do
        new_attrs = {
          name: 'new name',
          bio: 'new bio'
        }
        put "/musicians/#{musician.id}", new_attrs, header
        musician.reload

        expect(musician.name).to eq 'new name'
        expect(musician.bio).to eq 'new bio'
      end

      it 'allows add new albums' do
        file = File.open('spec/fixtures/images/genesis_foxtrot.jpg')
        new_albums = [
          {
            name: 'new album',
            cover_photo: Rack::Test::UploadedFile.new(file, 'image/png')
          }
        ]
        put "/musicians/#{musician.id}", { new_albums: new_albums },
          { 'Content-Type' => 'multipart/form-data' }

        expect(last_response.status).to eq 204
        expect(musician.reload.albums.first.cover_photo.keys).to eq %i[original small thumbnail]
      end

      it 'allows remove album' do
        create_list :album, 2, artist: musician
        expect(musician.reload.albums.size).to eq 2

        input = { remove_album_ids: [ musician.album_ids.first ] }
        put "/musicians/#{musician.id}", input, { 'Content-Type' => 'multipart/form-data' }
        musician.reload

        expect(last_response.status).to eq 204
        expect(musician.reload.albums.size).to eq 1
      end

      it 'raises an exeption on error' do
        put "/musicians/#{musician.id}", { name: '' }, header

        expect(last_response.status).to eq 422
        expect(last_response.body).to match(/Validation failed/)
      end
    end
  end
end
