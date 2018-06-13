require 'request_helper'

module MusicAPI
  RSpec.describe Musicians::Index, type: :request do
    def app
      described_class
    end

    before { create_list :musician_with_songs, 5 }

    context 'renders all musicians' do
      it 'return musicians' do
        get '/musicians'

        expect(last_response.status).to eq 200
        result = JSON.parse last_response.body
        expect(result.size).to eq 5
        expect(result[3]['songs'].size).to eq 3
      end
    end
  end
end
