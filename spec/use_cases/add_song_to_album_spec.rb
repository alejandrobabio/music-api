require 'spec_helper'
require_relative '../../app/use_cases/add_song_to_album.rb'

module MusicAPI
  RSpec.describe UseCases::AddSongToAlbum do
    let(:album_class) { double }
    let(:song_class) { double }
    let(:use_case) { described_class.new(album_class, song_class) }

    context 'with valid data' do
      it 'adds the song to the album' do
        params = { album_id: 12, song_id: 685 }

        album_instance = double('Album')
        song_instance = double('Song')
        songs_collection = double('songs_collection')
        allow(album_class).to receive(:find).with(12).and_return(album_instance)
        allow(song_class).to receive(:find).with(685).and_return(song_instance)
        allow(song_instance).to receive(:[]).with(:album_id).and_return(nil)
        allow(album_instance).to receive(:songs).and_return(songs_collection)

        expect(songs_collection).to receive(:<<).with(song_instance)

        use_case.call(params)
      end
    end

    context 'with errors' do
      it 'do not add if the album does not exists' do
        params = { album_id: 12, song_id: 685 }

        allow(album_class).to receive(:find).with(12).and_raise(StandardError.new)

        expect {
          use_case.call(params)
        }.to raise_exception(StandardError)
      end

      it 'do not add if the song does not exists' do
        params = { album_id: 12, song_id: 685 }

        allow(album_class).to receive(:find).with(12)
        allow(song_class).to receive(:find).with(685).and_raise(StandardError.new)

        expect {
          use_case.call(params)
        }.to raise_exception(StandardError)
      end

      it 'do not add if the song belongs to another album' do
        params = { album_id: 12, song_id: 685 }

        album_instance = double('Album')
        song_instance = double('Song')
        allow(album_class).to receive(:find).with(12).and_return(album_instance)
        allow(song_class).to receive(:find).with(685).and_return(song_instance)
        allow(song_instance).to receive(:[]).with(:album_id).and_return(2)

        expect {
          use_case.call(params)
        }.to raise_exception(UseCases::InconsistentData)
      end
    end
  end
end
