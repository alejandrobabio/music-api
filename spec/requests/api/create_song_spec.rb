require 'request_helper'

module MusicAPI
  RSpec.describe Songs::Create, type: :request do
    def app
      described_class
    end

    let(:header) { { 'Content-Type' => 'application/json' } }

    describe 'POST /songs' do
      context 'returns created' do
        it 'with a new band' do
          input = attributes_for :song
          input[:band] = attributes_for :band
          post '/songs', input, header

          expect(last_response.status).to eq 201
          result = JSON.parse last_response.body
          expect(result['name']).to eq input[:name]
          expect(result['duration']).to eq input[:duration]
          expect(result['genre']).to eq input[:genre]
          expect(result['version']).to eq input[:version]
          expect(result['band']['name']).to eq input[:band][:name]
          expect(result['band']['bio']).to eq input[:band][:bio]
        end

        it 'with a new band and an new album' do
          input = attributes_for :song
          input[:band] = attributes_for :band
          input[:album] = attributes_for :album
          post '/songs', input, header

          expect(last_response.status).to eq 201
          result = JSON.parse last_response.body
          expect(result['name']).to eq input[:name]
          expect(result['duration']).to eq input[:duration]
          expect(result['genre']).to eq input[:genre]
          expect(result['version']).to eq input[:version]
          expect(result['band']['name']).to eq input[:band][:name]
          expect(result['band']['bio']).to eq input[:band][:bio]
          expect(result['album']['name']).to eq input[:album][:name]
        end

        it 'with a new musician' do
          input = attributes_for :song
          input[:musician] = attributes_for :musician
          post '/songs', input, header

          expect(last_response.status).to eq 201
          result = JSON.parse last_response.body
          expect(result['name']).to eq input[:name]
          expect(result['duration']).to eq input[:duration]
          expect(result['genre']).to eq input[:genre]
          expect(result['version']).to eq input[:version]
          expect(result['musician']['name']).to eq input[:musician][:name]
          expect(result['musician']['bio']).to eq input[:musician][:bio]
        end

        it 'with a new musician and an new album' do
          input = attributes_for :song
          input[:musician] = attributes_for :musician
          input[:album] = attributes_for :album
          post '/songs', input, header

          expect(last_response.status).to eq 201
          result = JSON.parse last_response.body
          expect(result['name']).to eq input[:name]
          expect(result['duration']).to eq input[:duration]
          expect(result['genre']).to eq input[:genre]
          expect(result['version']).to eq input[:version]
          expect(result['musician']['name']).to eq input[:musician][:name]
          expect(result['musician']['bio']).to eq input[:musician][:bio]
          expect(result['album']['name']).to eq input[:album][:name]
        end

        it 'with an existed musician' do
          input = attributes_for :song
          musician = create :musician
          input[:musician] = { id: musician.id }
          post '/songs', input, header

          expect(last_response.status).to eq 201
          result = JSON.parse last_response.body
          expect(result['name']).to eq input[:name]
          expect(result['duration']).to eq input[:duration]
          expect(result['genre']).to eq input[:genre]
          expect(result['version']).to eq input[:version]
          expect(result['musician']['name']).to eq musician[:name]
          expect(result['musician']['bio']).to eq musician[:bio]
          expect(result['musician']['id']).to eq input[:musician][:id]
        end

        it 'with an existed musician and a new album' do
          input = attributes_for :song
          musician = create :musician
          input[:musician] = { id: musician.id }
          input[:album] = attributes_for :album
          post '/songs', input, header

          expect(last_response.status).to eq 201
          result = JSON.parse last_response.body
          expect(result['name']).to eq input[:name]
          expect(result['duration']).to eq input[:duration]
          expect(result['genre']).to eq input[:genre]
          expect(result['version']).to eq input[:version]
          expect(result['musician']['name']).to eq musician[:name]
          expect(result['musician']['bio']).to eq musician[:bio]
          expect(result['musician']['id']).to eq input[:musician][:id]
          expect(result['album']['name']).to eq input[:album][:name]
        end

        it 'with an existed musician and an existed album' do
          input = attributes_for :song
          musician = create :musician
          input[:musician] = { id: musician.id }
          album = create :album, artist: musician
          input[:album] = { id: album.id }
          post '/songs', input, header

          expect(last_response.status).to eq 201
          result = JSON.parse last_response.body
          expect(result['name']).to eq input[:name]
          expect(result['duration']).to eq input[:duration]
          expect(result['genre']).to eq input[:genre]
          expect(result['version']).to eq input[:version]
          expect(result['musician']['name']).to eq musician[:name]
          expect(result['musician']['bio']).to eq musician[:bio]
          expect(result['musician']['id']).to eq input[:musician][:id]
          expect(result['album']['id']).to eq input[:album][:id]
          expect(result['album']['name']).to eq album[:name]
        end

        it 'with an existed band' do
          input = attributes_for :song
          band = create :band
          input[:band] = { id: band.id }
          post '/songs', input, header

          expect(last_response.status).to eq 201
          result = JSON.parse last_response.body
          expect(result['name']).to eq input[:name]
          expect(result['duration']).to eq input[:duration]
          expect(result['genre']).to eq input[:genre]
          expect(result['version']).to eq input[:version]
          expect(result['band']['name']).to eq band[:name]
          expect(result['band']['bio']).to eq band[:bio]
          expect(result['band']['id']).to eq input[:band][:id]
        end

        it 'with an existed band and a new album' do
          input = attributes_for :song
          band = create :band
          input[:band] = { id: band.id }
          input[:album] = attributes_for :album
          post '/songs', input, header

          expect(last_response.status).to eq 201
          result = JSON.parse last_response.body
          expect(result['name']).to eq input[:name]
          expect(result['duration']).to eq input[:duration]
          expect(result['genre']).to eq input[:genre]
          expect(result['version']).to eq input[:version]
          expect(result['band']['name']).to eq band[:name]
          expect(result['band']['bio']).to eq band[:bio]
          expect(result['band']['id']).to eq input[:band][:id]
          expect(result['album']['name']).to eq input[:album][:name]
        end

        it 'with an existed band and an existed album' do
          input = attributes_for :song
          band = create :band
          input[:band] = { id: band.id }
          album = create :album, artist: band
          input[:album] = { id: album.id }
          post '/songs', input, header

          expect(last_response.status).to eq 201
          result = JSON.parse last_response.body
          expect(result['name']).to eq input[:name]
          expect(result['duration']).to eq input[:duration]
          expect(result['genre']).to eq input[:genre]
          expect(result['version']).to eq input[:version]
          expect(result['band']['name']).to eq band[:name]
          expect(result['band']['bio']).to eq band[:bio]
          expect(result['band']['id']).to eq input[:band][:id]
          expect(result['album']['id']).to eq input[:album][:id]
          expect(result['album']['name']).to eq album[:name]
        end

        context 'with photos' do
          it 'with an existed musician and an existed album' do
            input = attributes_for :song
            musician = create :musician
            input[:musician] = { id: musician.id }
            album = create :album, artist: musician
            input[:album] = { id: album.id }
            foxtrot = File.open('spec/fixtures/images/genesis_foxtrot.jpg')
            trespass = File.open('spec/fixtures/images/genesis_trespass.jpg')
            input.merge!(
              photos: [
                { title: 'Foxtrot', image: Rack::Test::UploadedFile.new(foxtrot, 'image/png') },
                { title: 'Trespass', image: Rack::Test::UploadedFile.new(trespass, 'image/png') }
              ]
            )
            post '/songs', input, { 'Content-Type' => 'multipart/form-data' }

            expect(last_response.status).to eq 201
            result = JSON.parse last_response.body
            expect(result['name']).to eq input[:name]
            expect(result['photos'][0]['title']).to eq 'Foxtrot'
            expect(result['photos'][0]['image'].keys).to eq %w[original small thumbnail]
            expect(result['photos'][1]['title']).to eq 'Trespass'
            expect(result['photos'][1]['image'].keys).to eq %w[original small thumbnail]
          end
        end

        context 'with track' do
          it 'with an existed musician and an existed album' do
            input = attributes_for :song
            musician = create :musician
            input[:musician] = { id: musician.id }
            album = create :album, artist: musician
            input[:album] = { id: album.id }
            sample_audio = File.open('spec/fixtures/audio/sample_audio.mp3')
            input.merge!(
              track: Rack::Test::UploadedFile.new(sample_audio, 'audio/mpeg')
            )
            post '/songs', input, { 'Content-Type' => 'multipart/form-data' }

            expect(last_response.status).to eq 201
            result = JSON.parse last_response.body
            expect(result['name']).to eq input[:name]
            expect(result['track']['metadata']['filename']).to eq 'sample_audio.mp3'
            expect(result['track']['metadata']['mime_type']).to eq 'audio/mpeg'
          end
        end
      end
    end

    describe 'respond with errors' do
      let(:song) { attributes_for :song }
      let(:new_musician) { attributes_for :musician }
      let(:new_band) { attributes_for :band }
      let(:new_album) { attributes_for :album }

      it 'without artist' do
        post '/songs', song, header
        expect(last_response.status).to eq 400
      end

      it 'with band and musician' do
        input = song.merge(musician: new_musician, band: new_band)
        post '/songs', input, header
        expect(last_response.status).to eq 400
      end

      it 'without data' do
        post '/songs', {}, header
        expect(last_response.status).to eq 400
        expect(last_response.body).to match(/name is missing/)
        expect(last_response.body).to match(/duration is missing/)
        expect(last_response.body).to match(/genre is missing/)
        expect(last_response.body).to match(/version is missing/)
        expect(last_response.body).to match(
          /musician, band are missing, exactly one parameter must be provided/
        )
      end

      it 'with artist id and bio' do
        input = song.merge(
          musician: { id: 222, bio: new_musician[:bio] }
        )
        post '/songs', input, header
        expect(last_response.status).to eq 400
      end

      it 'with album id and name' do
        input = song.merge(
          musician: new_musician, album: new_album.merge(id: 11)
        )
        post '/songs', input, header
        expect(last_response.status).to eq 400
      end
    end
  end
end
