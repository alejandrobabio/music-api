require 'spec_helper'
require_relative '../../app/use_cases/remove_song_from_playlist.rb'

module MusicAPI
  RSpec.describe UseCases::RemoveSongFromPlaylist do
    let(:playlist_class) { double }
    let(:song_class) { double }
    let(:use_case) { described_class.new(playlist_class, song_class) }

    context 'with valid data' do
      it 'remove song from the playlist' do
        params = { id: 12, song_id: 685 }

        song_instance = double('Song')
        playlist_instance = double('Playlist')
        songs_relation = double('songs')
        allow(playlist_class).to receive(:find).with(12).and_return(playlist_instance)
        allow(song_class).to receive(:find).with(685).and_return(song_instance)
        allow(playlist_instance).to receive(:song_ids).and_return([685])
        allow(playlist_instance).to receive(:songs).and_return(songs_relation)
        allow(song_instance).to receive(:[]).with(:id).and_return(685)

        expect(songs_relation).to receive(:destroy).with(song_instance)

        use_case.call(params)
      end
    end

    context 'with errors' do
      it 'raises an error if the song does not belongs to the playlist' do
        params = { id: 12, song_id: 685 }

        song_instance = double('Song')
        playlist_instance = double('Playlist')
        allow(playlist_class).to receive(:find).with(12).and_return(playlist_instance)
        allow(song_class).to receive(:find).with(685).and_return(song_instance)
        allow(playlist_instance).to receive(:song_ids).and_return([])
        allow(song_instance).to receive(:[]).with(:id).and_return(685)

        expect {
          use_case.call(params)
        }.to raise_exception(UseCases::InconsistentData)
      end
    end
  end
end
