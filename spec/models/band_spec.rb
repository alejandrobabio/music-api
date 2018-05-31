require 'db_helper'

RSpec.describe Band, type: :model do
  it_behaves_like 'an Artist' do
    subject { Band.new(attributes_for :band) }
  end
end
