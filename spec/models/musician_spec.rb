require 'db_helper'

RSpec.describe Musician, type: :model do
  let(:musician) { Musician.new(attributes_for :musician) }

  it { expect(musician).to be_a_kind_of Musician  }

  it 'is valid with name and empty bio'
  it 'is not valid with a name duplicated'
  it 'is not valid with an empty name'
end

