require 'request_helper'

module MusicAPI
  RSpec.describe Songs::Update, type: :request do
    def app
      described_class
    end

    let(:header) { { 'Content-Type' => 'application/json' } }

    let(:song) { create :song }

    describe 'PUT /songs/:id' do
      it 'returns updated status' do
        put "/songs/#{song.id}", { name: 'new name' }, header

        expect(last_response.status).to eq 204
      end

      it 'updates the song attributes' do
        new_attrs = {
          name: 'new name',
          duration: 300,
          genre: 'Classical',
          version: 'The Opera',
        }
        put "/songs/#{song.id}", new_attrs, header
        song.reload

        expect(song.name).to eq 'new name'
        expect(song.duration).to eq 300
        expect(song.genre).to eq 'Classical'
        expect(song.version).to eq 'The Opera'
      end

      it 'allows change the album' do
        new_album = create :album, artist: song.artist
        new_attrs = { album_id: new_album.id }
        put "/songs/#{song.id}", new_attrs, header
        song.reload

        expect(song.album).to eq new_album
      end

      it 'allows change the artist from band to musician' do
        expect(song.artist).to be_a_kind_of Band
        new_musician = create :musician
        new_attrs = { musician_id: new_musician.id }
        put "/songs/#{song.id}", new_attrs, header
        song.reload

        expect(song.artist).to eq new_musician
      end

      it 'allows change the artist to a new band' do
        expect(song.artist).to be_a_kind_of Band
        new_band = create :band
        new_attrs = { band_id: new_band.id }
        put "/songs/#{song.id}", new_attrs, header
        song.reload

        expect(song.artist).to eq new_band
      end

      it 'does not allow to inform album and musician' do
        new_attrs = { band_id: 5, musician_id: 3 }
        put "/songs/#{song.id}", new_attrs, header

        expect(last_response.status).to eq 400
        expect(last_response.body)
          .to match(/musician_id, band_id are mutually exclusive/)
      end

      it 'allows add new photos' do
        foxtrot = File.open('spec/fixtures/images/genesis_foxtrot.jpg')
        trespass = File.open('spec/fixtures/images/genesis_trespass.jpg')
        new_attrs = {
          new_photos: [
            { title: 'Foxtrot', image: Rack::Test::UploadedFile.new(foxtrot, 'image/png') },
            { title: 'Trespass', image: Rack::Test::UploadedFile.new(trespass, 'image/png') }
          ]
        }
        put "/songs/#{song.id}", new_attrs, { 'Content-Type' => 'multipart/form-data' }
        song.reload

        expect(last_response.status).to eq 204
        expect(song.photos.first.title).to eq 'Foxtrot'
        expect(song.photos.first.image.keys).to eq %i[original small thumbnail]
        expect(song.photos.last.title).to eq 'Trespass'
        expect(song.photos.last.image.keys).to eq %i[original small thumbnail]
      end

      it 'allows remove photos' do
        foxtrot = File.open('spec/fixtures/images/genesis_foxtrot.jpg')
        trespass = File.open('spec/fixtures/images/genesis_trespass.jpg')
        photos = [
          { title: 'Foxtrot', image: Rack::Test::UploadedFile.new(foxtrot, 'image/png') },
          { title: 'Trespass', image: Rack::Test::UploadedFile.new(trespass, 'image/png') }
        ]
        song.photos.create! photos
        expect(song.reload.photos.size).to eq 2

        input = { remove_photo_ids: [ song.photo_ids.first ] }
        put "/songs/#{song.id}", input, { 'Content-Type' => 'multipart/form-data' }
        song.reload

        expect(last_response.status).to eq 204
        expect(song.reload.photos.size).to eq 1
        expect(song.photos.first.title).to eq 'Trespass'
      end

      it 'raises an exeption on error' do
        put "/songs/#{song.id}", { name: '' }, header

        expect(last_response.status).to eq 422
        expect(last_response.body).to match(/Validation failed/)
      end
    end
  end
end
