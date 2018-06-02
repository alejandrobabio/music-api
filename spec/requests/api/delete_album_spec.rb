require 'request_helper'

module MusicAPI
  RSpec.describe Albums::Delete, type: :request do
    def app
      described_class
    end

    let(:header) { { 'Content-Type' => 'application/json' } }
    let!(:album) { create :album }

    describe "DELETE /albums/:id" do
      it 'returns 204 status' do
        delete "/albums/#{album.id}", header

        expect(last_response.status).to eq 204
      end

      it "deletes the album" do
        expect {
          delete "/albums/#{album.id}", header
        }.to change(Album, :count).by(-1)
      end

      it "can't delete if it does not exists" do
        delete "/albums/99999", header

        expect(last_response.status).to eq 404
      end
    end
  end
end
