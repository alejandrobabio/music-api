require 'db_helper'

RSpec.describe Album, type: :model do
  subject { Album.new(attributes_for :album) }

  it { is_expected.to be_a_kind_of described_class  }

  it { is_expected.to validate_presence_of :name }

  it { is_expected.to belong_to(:artist) }

  it 'is not valid with a name duplicated' do
    subject.save
    new_subject = described_class.new(name: subject.name)
    expect(new_subject.valid?).to be_falsey
  end
end
