require 'db_helper'

RSpec.describe Playlist, type: :model do
  subject { build :playlist }

  it { is_expected.to have_many(:playlist_songs) }
  it { is_expected.to have_many(:songs).through(:playlist_songs) }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_uniqueness_of :name }
end
