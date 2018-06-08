require 'db_helper'

RSpec.describe PlayList, type: :model do
  subject { build :play_list }

  it { is_expected.to have_many(:play_list_songs) }
  it { is_expected.to have_many(:songs).through(:play_list_songs) }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_uniqueness_of :name }
end
