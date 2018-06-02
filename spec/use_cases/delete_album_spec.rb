require 'spec_helper'
require_relative '../../app/use_cases/delete_album'

module MusicAPI
  RSpec.describe MusicAPI::UseCases::DeleteAlbum do
    let(:model_class) { double }
    let(:use_case) { described_class.new(model_class) }
    let(:id) { 123 }

    context 'when it deletes record' do
      before do
        expect(model_class).to receive(:destroy).with(id)
      end

      it { expect(use_case.call(id)).to be_empty }
    end

    context "when it can't delete the record" do
      before do
        allow(model_class).to receive(:destroy).with(id)
          .and_raise(StandardError.new)
      end

      it 'raises an exception' do
        expect {
          use_case.call(id)
        }.to raise_exception(StandardError)
      end
    end
  end
end
