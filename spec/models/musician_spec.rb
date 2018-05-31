require 'db_helper'

RSpec.describe Musician, type: :model do
  it_behaves_like 'an Artist' do
    subject { Musician.new(attributes_for :musician) }
  end
end

