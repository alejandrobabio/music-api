require 'spec_helper'
require_relative '../../app/use_cases/update_album.rb'

module MusicAPI
  RSpec.describe UseCases::UpdateAlbum do
    let(:model_class) { double }
    let(:artist_class) { double }

    context 'when it updates' do
      it 'with a new album name' do
        use_case = described_class.new(model_class)
        params = { id: 1, name: 'new name' }

        album_instance = double('Album')
        expect(model_class).to receive(:find).with(params[:id])
          .and_return(album_instance)
        expect(album_instance).to receive(:assign_attributes).with(name: 'new name')
        expect(album_instance).to receive(:save!).and_return(true)

        expect(use_case.call(params)).to be_truthy
      end

      it 'with an artist_id' do
        use_case = described_class.new(model_class, artist_class)
        params = { id: 1, artist_id: 5 }

        album_instance = double('Album')
        expect(model_class).to receive(:find).with(params[:id])
          .and_return(album_instance)
        artist_instance = double('Artist')
        expect(artist_class).to receive(:find).with(5)
          .and_return(artist_instance)
        expect(album_instance).to receive(:artist=).with(artist_instance)
        expect(album_instance).to receive(:save!).and_return(true)

        expect(use_case.call(params)).to be_truthy
      end
    end

    context "when it can't update the album" do
      it 'raises an exception' do
        use_case = described_class.new(model_class)
        params = { id: 1, name: 'new name' }

        album_instance = double('Album')
        expect(model_class).to receive(:find).with(params[:id])
          .and_return(album_instance)
        expect(album_instance).to receive(:assign_attributes).with(name: 'new name')
        expect(album_instance).to receive(:save!)
          .and_raise(StandardError.new)

        expect {
          use_case.call(params)
        }.to raise_exception(StandardError)
      end
    end
  end
end
