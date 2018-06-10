require 'request_helper'

RSpec.describe Photo, type: :model do
  subject { Photo.new(attributes_for :photo) }

  it { is_expected.to be_a_kind_of described_class }
  it { is_expected.to belong_to :song }

  it 'has a image attached' do
    file = File.open('spec/fixtures/images/genesis_foxtrot.jpg')
    subject.update(image: Rack::Test::UploadedFile.new(file, 'image/png'))

    subject.reload
    %i[original small thumbnail].each do |image_size|
      expect(subject.image.keys).to include image_size
    end
  end
end
