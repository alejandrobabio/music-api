require 'db_helper'

RSpec.describe PlaylistSong, type: :model do
  it { is_expected.to belong_to(:playlist) }
  it { is_expected.to belong_to(:song) }

  it { is_expected.to validate_presence_of(:playlist_id) }
  it { is_expected.to validate_presence_of(:song_id) }

  it 'validates uniqueness for song' do
    song = create :song
    playlist = create :playlist

    playlist_song = PlaylistSong.new(song: song, playlist: playlist)

    expect(playlist_song.valid?).to be_truthy

    playlist_song.save!

    new_playlist_song = PlaylistSong.new(song: song, playlist: playlist)

    expect(new_playlist_song.valid?).to be_falsey
    expect(new_playlist_song.errors.messages[:playlist_id])
      .to eq ['has already been taken']
    expect(new_playlist_song.errors.messages[:song_id])
      .to eq ['has already been taken']

    new_song = create :song
    new_playlist_song = PlaylistSong.new(song: new_song, playlist: playlist)
    expect(playlist_song.valid?).to be_truthy

    new_playlist = create :playlist
    new_playlist_song = PlaylistSong.new(song: song, playlist: new_playlist)
    expect(playlist_song.valid?).to be_truthy
  end
end

