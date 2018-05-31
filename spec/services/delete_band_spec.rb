require 'spec_helper'
require_relative '../../app/services/delete_band.rb'

module MusicAPI
  RSpec.describe Services::DeleteBand do
    let(:model_class) { double }
    let(:service) { described_class.new(model_class) }
    let(:id) { 123 }

    context 'when it deletes record' do
      before do
        expect(model_class).to receive(:destroy).with(id)
      end

      it { expect(service.call(id)).to be_empty }
    end

    context "when it can't delete the record" do
      before do
        allow(model_class).to receive(:destroy).with(id)
          .and_raise(StandardError.new)
      end

      it 'raises an exception' do
        expect {
          service.call(id)
        }.to raise_exception(StandardError)
      end
    end
  end
end
