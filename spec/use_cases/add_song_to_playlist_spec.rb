require 'spec_helper'
require_relative '../../app/use_cases/add_song_to_playlist.rb'

module MusicAPI
  RSpec.describe UseCases::AddSongToPlaylist do
    let(:playlist_class) { double }
    let(:song_class) { double }
    let(:use_case) { described_class.new(playlist_class, song_class) }

    context 'with valid data' do
      it 'adds the song to the playlist' do
        params = { id: 12, song_id: 685 }

        playlist_instance = double('Playlist')
        song_instance = double('Song')
        songs_collection = double('songs_collection')
        allow(playlist_class).to receive(:find).with(12).and_return(playlist_instance)
        allow(song_class).to receive(:find).with(685).and_return(song_instance)
        allow(song_instance).to receive(:[]).with(:playlist_id).and_return(nil)
        allow(playlist_instance).to receive(:songs).and_return(songs_collection)

        expect(songs_collection).to receive(:<<).with(song_instance)

        use_case.call(params)
      end
    end

    context 'with errors' do
      it 'do not add if the playlist does not exists' do
        params = { id: 12, song_id: 685 }

        allow(playlist_class).to receive(:find).with(12).and_raise(StandardError.new)

        expect {
          use_case.call(params)
        }.to raise_exception(StandardError)
      end

      it 'do not add if the song does not exists' do
        params = { id: 12, song_id: 685 }

        allow(playlist_class).to receive(:find).with(12)
        allow(song_class).to receive(:find).with(685).and_raise(StandardError.new)

        expect {
          use_case.call(params)
        }.to raise_exception(StandardError)
      end
    end
  end
end
