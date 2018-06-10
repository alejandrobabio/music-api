require 'db_helper'

RSpec.describe Song, type: :model do
  subject { build :song }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :version }
  it { is_expected.to validate_presence_of :artist }
  it { is_expected.to belong_to :album }
  it { is_expected.to belong_to(:artist) }
  it { is_expected.to have_many(:playlist_songs) }
  it { is_expected.to have_many(:playlists).through(:playlist_songs) }
  it { is_expected.to have_many(:photos) }

  it 'is not valid with name and version duplicated' do
    subject.save
    song = Song.new subject.attributes
    expect(song).not_to be_valid
  end

  it 'is valid with diferent artist' do
    subject.save
    song = Song.new subject.attributes.merge(artist: build(:musician))
    expect(song).to be_valid
  end

  it 'is valid with diferent version' do
    subject.save
    song = Song.new subject.attributes.merge(version: 'v11')
    expect(song).to be_valid
  end
end
