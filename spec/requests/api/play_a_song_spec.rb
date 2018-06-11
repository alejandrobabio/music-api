require 'request_helper'

module MusicAPI
  RSpec.describe Songs::Play, type: :request do
    def app
      described_class
    end

    let(:header) { { 'Content-Type' => 'application/json' } }
    let(:audio) { StringIO.new(File.read('spec/fixtures/audio/sample_audio.mp3')) }
    let(:song) { create :song, track: audio }

    describe 'GET /songs/:id/play' do
      it 'streams the song track' do
        get "/songs/#{song.id}/play", {}, header

        expect(last_response.status).to eq 200
        expect(last_response.body.size).to eq audio.size
      end
    end
  end
end
