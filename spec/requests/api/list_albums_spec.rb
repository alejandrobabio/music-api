require 'request_helper'

module MusicAPI
  RSpec.describe Albums::Index, type: :request do
    def app
      described_class
    end

    before { create_list :album_with_songs, 5 }

    context 'renders all albums' do
      it 'return albums' do
        get '/albums'

        expect(last_response.status).to eq 200
        result = JSON.parse last_response.body
        expect(result.size).to eq 5
        expect(result[3]['songs'].size).to eq 3
      end
    end
  end
end
