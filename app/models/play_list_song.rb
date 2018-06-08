class PlayListSong < ActiveRecord::Base
  belongs_to :song
  belongs_to :play_list
end
