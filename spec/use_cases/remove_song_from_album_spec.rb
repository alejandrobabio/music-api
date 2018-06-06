require 'spec_helper'
require_relative '../../app/use_cases/remove_song_from_album.rb'

module MusicAPI
  RSpec.describe UseCases::RemoveSongFromAlbum do
    let(:song_class) { double }
    let(:use_case) { described_class.new(song_class) }

    context 'with valid data' do
      it 'remove song from the album' do
        params = { id: 12, song_id: 685 }

        song_instance = double('Song')
        allow(song_class).to receive(:find).with(685).and_return(song_instance)
        allow(song_instance).to receive(:[]).with(:album_id).and_return(12)

        expect(song_instance).to receive(:update).with(album_id: nil)

        use_case.call(params)
      end
    end

    context 'with errors' do
      it 'raises an error if the song does not belongs to the album' do
        params = { id: 12, song_id: 685 }

        song_instance = double('Song')
        allow(song_class).to receive(:find).with(685).and_return(song_instance)
        allow(song_instance).to receive(:[]).with(:album_id).and_return(55)

        expect {
          use_case.call(params)
        }.to raise_exception(UseCases::InconsistentData)
      end

      it 'raises an error if the song does not belongs to any album' do
        params = { id: 12, song_id: 685 }

        song_instance = double('Song')
        allow(song_class).to receive(:find).with(685).and_return(song_instance)
        allow(song_instance).to receive(:[]).with(:album_id).and_return(nil)

        expect {
          use_case.call(params)
        }.to raise_exception(UseCases::InconsistentData)
      end
    end
  end
end
