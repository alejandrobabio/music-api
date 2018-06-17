RSpec.shared_examples 'an Artist' do
  it { is_expected.to be_a_kind_of described_class  }

  it { is_expected.to validate_presence_of :name }

  it { is_expected.to have_many(:songs) }
  it { is_expected.to have_many :albums }

  it 'is valid with name and empty bio' do
    subject.bio = nil
    expect(subject.valid?).to be_truthy
  end

  it 'is not valid with a name duplicated' do
    subject.save
    new_subject = described_class.new(name: subject.name)
    expect(new_subject.valid?).to be_falsey
  end
end
