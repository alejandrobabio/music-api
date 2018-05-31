require 'request_helper'

module MusicAPI
  RSpec.describe Bands::Delete, type: :request do
    def app
      described_class
    end

    let(:header) { { 'Content-Type' => 'application/json' } }
    let!(:band) { create :band }

    describe 'DELETE /bands/:id' do
      it 'returns 204 status' do
        delete "/bands/#{band.id}", header

        expect(last_response.status).to eq 204
      end

      it 'deletes the band' do
        expect {
          delete "/bands/#{band.id}", header
        }.to change(Band, :count).by(-1)
      end

      it "can't delete if it does not exists" do
        delete "/bands/99999", header

        expect(last_response.status).to eq 404
      end
    end
  end
end
