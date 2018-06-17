require 'request_helper'

module MusicAPI
  RSpec.describe Songs::Delete, type: :request do
    def app
      described_class
    end

    let(:header) { { 'Content-Type' => 'application/json' } }
    let!(:song) { create :song }

    describe "DELETE /songs/:id" do
      it 'returns 204 status' do
        delete "/songs/#{song.id}", header

        expect(last_response.status).to eq 204
      end

      it "deletes the song" do
        expect {
          delete "/songs/#{song.id}", header
        }.to change(Song, :count).by(-1)
      end

      it "can't delete if it does not exists" do
        delete "/songs/99999", header

        expect(last_response.status).to eq 404
      end
    end
  end
end
