require 'db_helper'

RSpec.describe Band, type: :model do
  let(:band) { Band.new(attributes_for :band) }

  it { expect(band).to be_a_kind_of Band  }

  it 'is valid with name and empty bio'
  it 'is not valid with a name duplicated'
  it 'is not valid with an empty name'
end
