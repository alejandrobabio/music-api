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
