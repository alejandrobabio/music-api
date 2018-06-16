require 'request_helper'

module MusicAPI
  RSpec.describe Songs::Index, type: :request do
    def app
      described_class
    end

    before { create_list :song_with_album, 5 }

    context 'renders all songs' do
      it 'return songs' do
        get '/songs'

        expect(last_response.status).to eq 200
        result = JSON.parse last_response.body
        expect(result.size).to eq 5
        expect(result[3]['album'].keys).to eq %w[id name cover_photo]
        expect(result[3]['band'].keys).to eq %w[id name bio]
      end
    end
  end
end
