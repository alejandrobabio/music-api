require 'db_helper'

RSpec.describe PlayListSong, type: :model do
  it { is_expected.to belong_to(:play_list) }
  it { is_expected.to belong_to(:song) }
end

