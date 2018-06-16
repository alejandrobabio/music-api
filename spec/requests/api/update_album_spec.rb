require 'request_helper'

module MusicAPI
  RSpec.describe Albums::Update, type: :request do
    def app
      described_class
    end

    let(:header) { { 'Content-Type' => 'application/json' } }

    describe 'PUT /albums/:id' do
      it 'updates the album name' do
        album = create :album
        put "/albums/#{album.id}", { name: 'new name' }, header

        expect(last_response.status).to eq 204
        expect(album.reload.name).to eq 'new name'
      end

      it 'allows change the artist' do
        album = create :album_with_band
        expect(album.artist).to be_a_kind_of Band
        musician = create :musician

        put "/albums/#{album.id}", { musician_id: musician.id }, header

        expect(album.reload.artist).to eq musician
      end

      it 'allows change the cover_photo' do
        album = create :album
        expect(album.cover_photo).to be_nil

        file = File.open('spec/fixtures/images/genesis_foxtrot.jpg')
        input = { cover_photo: Rack::Test::UploadedFile.new(file, 'image/png') }
        put "/albums/#{album.id}", input,
          { 'Content-Type' => 'multipart/form-data' }

        expect(last_response.status).to eq 204
        expect(album.reload.cover_photo.keys).to eq %i[original small thumbnail]
      end
    end
  end
end
