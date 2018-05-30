require 'db_helper'

RSpec.describe Band, type: :model do
  let(:band) { Band.new(attributes_for :band) }

  subject { band }

  it { is_expected.to be_a_kind_of Band  }

  it { is_expected.to validate_presence_of :name }

  it 'is valid with name and empty bio' do
    band.bio = nil
    expect(band.valid?).to be_truthy
  end

  it 'is not valid with a name duplicated' do
    band.save
    new_band = Band.new(name: band.name)
    expect(new_band.valid?).to be_falsey
  end
end
