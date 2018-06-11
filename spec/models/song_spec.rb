require 'request_helper'

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

  it 'has a track audio file' do
    file = File.open('spec/fixtures/audio/sample_audio.mp3')
    subject.update(track: Rack::Test::UploadedFile.new(file, 'audio/mpeg'))
    subject.reload

    expect(subject.track.metadata['filename']).to eq 'sample_audio.mp3'
    expect(subject.track.metadata['mime_type']).to eq 'audio/mpeg'
    expect(subject.track.data['storage']).to eq 'store'
  end
end
