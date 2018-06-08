require 'db_helper'

RSpec.describe PlaylistSong, type: :model do
  it { is_expected.to belong_to(:playlist) }
  it { is_expected.to belong_to(:song) }
end

