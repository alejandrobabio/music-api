require 'request_helper'

RSpec.describe Album, type: :model do
  subject { Album.new(attributes_for :album) }

  it { is_expected.to be_a_kind_of described_class  }

  it { is_expected.to validate_presence_of :name }

  it { is_expected.to belong_to(:artist) }

  it { is_expected.to have_many(:songs).dependent(:nullify) }

  it 'is not valid with a name duplicated' do
    subject.save
    new_subject = described_class.new(name: subject.name)
    expect(new_subject.valid?).to be_falsey
  end

  it 'has a cover_photo image' do
    file = File.open('spec/fixtures/images/genesis_foxtrot.jpg')
    subject.update(cover_photo: Rack::Test::UploadedFile.new(file, 'image/png'))

    subject.reload
    %i[original small thumbnail].each do |image_size|
      expect(subject.cover_photo.keys).to include image_size
      expect(subject.cover_photo[image_size].data['storage']).to eq 'store'
    end
  end
end
