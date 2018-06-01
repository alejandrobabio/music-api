RSpec.shared_examples 'request create an Artist' do |type:|
  let(:header) { { 'Content-Type' => 'application/json' } }

  describe "POST /#{type}s" do
    it 'returns created' do
      input = attributes_for type
      post "/#{type}s", input, header

      expect(last_response.status).to eq 201
      result = JSON.parse last_response.body
      expect(result['name']).to eq input[:name]
      expect(result['bio']).to eq input[:bio]
    end

    it "creates a new #{type}" do
      input = attributes_for type

      expect {
        post "/#{type}s", input, header
      }.to change(Kernel.const_get(type.to_s.capitalize), :count).by(1)
    end

    it "can't create with an empty name" do
      input = { name: nil }
      post "/#{type}s", input, header

      expect(last_response.status).to eq 422
      expect(last_response.body).to match(/Validation failed/)
    end
  end
end

RSpec.shared_examples 'request delete an Artist' do |type:|
  let(:header) { { 'Content-Type' => 'application/json' } }
  # FIXME: It should work with { create type }, review database cleaner
  let!(:artist) { Kernel.const_get(type.to_s.capitalize).first || create(type) }

  describe "DELETE /#{type}s/:id" do
    it 'returns 204 status' do
      delete "/#{type}s/#{artist.id}", header

      expect(last_response.status).to eq 204
    end

    it "deletes the #{type}" do
      expect {
        delete "/#{type}s/#{artist.id}", header
      }.to change(Kernel.const_get(type.to_s.capitalize), :count).by(-1)
    end

    it "can't delete if it does not exists" do
      delete "/#{type}s/99999", header

      expect(last_response.status).to eq 404
    end
  end

end
