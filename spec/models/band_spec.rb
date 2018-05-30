require 'db_helper'

RSpec.describe Band, type: :model do
  let(:band) { Band.new(attributes_for :band) }

  it { expect(band).to be_a_kind_of Band  }
end
