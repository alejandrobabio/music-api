RSpec.describe API::Base, type: :request do
  def app
    described_class
  end

  it 'hello world' do
    get '/'
    expect(last_response.body).to eq({hello: 'world!'}.to_json)
  end
end
