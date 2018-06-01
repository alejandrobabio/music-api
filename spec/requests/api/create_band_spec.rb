require 'request_helper'

module MusicAPI
  RSpec.describe Bands::Create, type: :request do
    def app
      described_class
    end

    it_behaves_like 'request create an Artist', type: :band
  end
end
