require 'request_helper'

module MusicAPI
  RSpec.describe Bands::Index, type: :request do
    def app
      described_class
    end

    before { create_list :band_with_songs, 5 }

    context 'renders all bands' do
      it 'return bands' do
        get '/bands'

        expect(last_response.status).to eq 200
        result = JSON.parse last_response.body
        expect(result.size).to eq 5
        expect(result[3]['songs'].size).to eq 3
      end
    end
  end
end
