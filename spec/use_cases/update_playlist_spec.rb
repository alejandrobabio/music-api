require 'spec_helper'
require_relative '../../app/use_cases/update_playlist.rb'

module MusicAPI
  RSpec.describe UseCases::UpdatePlaylist do
    let(:model_class) { double }
    let(:use_case) { described_class.new(model_class) }
    let(:params) { { id: 1, name: 'new name' } }

    context 'when it update with the new playlist name' do
      before do
        playlist_instance = double('Playlist')
        expect(model_class).to receive(:find).with(params[:id])
          .and_return(playlist_instance)
        expect(playlist_instance).to receive(:update!).with(name: params[:name])
          .and_return(true)
      end

      it { expect(use_case.call(params)).to be_truthy }
    end

    context "when it can't update the playlist" do
      before do
        playlist_instance = double('Playlist')
        expect(model_class).to receive(:find).with(params[:id])
          .and_return(playlist_instance)
        expect(playlist_instance).to receive(:update!).with(name: params[:name])
          .and_raise(StandardError.new)
      end

      it 'raises an exception' do
        expect {
          use_case.call(params)
        }.to raise_exception(StandardError)
      end
    end
  end
end
