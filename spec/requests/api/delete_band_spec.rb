require 'request_helper'

module MusicAPI
  RSpec.describe Bands::Delete, type: :request do
    def app
      described_class
    end

    it_behaves_like 'request delete an Artist', type: :band
  end
end
