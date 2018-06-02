require 'spec_helper'
require_relative '../../app/use_cases/create_album.rb'

module MusicAPI
  RSpec.describe MusicAPI::UseCases::CreateAlbum do
    let(:model_class) { double }
    let(:use_case) { described_class.new(model_class) }
    let(:params) { { some: :data } }

    context 'when it create a new record' do
      before do
        expect(model_class).to receive(:create!).with(params).and_return(:created)
      end

      it { expect(use_case.call(params)).to eq :created }
    end

    context "when it can't create a new record" do
      before do
        allow(model_class).to receive(:create!).with(params)
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
