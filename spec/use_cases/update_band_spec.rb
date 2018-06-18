require 'db_helper'

module MusicAPI
  RSpec.describe UseCases::UpdateBand do
    let(:model_class) { Band }
    let(:use_case) { described_class.new(model_class) }

    let(:band) { create :band_with_albums }

    describe 'when updates the band' do
      it "updates band's attributes" do
        album_ids = band.albums.map(&:id)
        new_attrs = {
          id: band.id,
          name: 'new name',
          bio: 'new bio',
          new_albums: [
            { name: 'new album name 1' },
            { name: 'new album name 2' }
          ],
          remove_album_ids: [ album_ids.first, album_ids.last ]
        }
        use_case.call(new_attrs)
        band.reload

        expect(band.name).to eq 'new name'
        expect(band.bio).to eq 'new bio'
        expect(band.albums.map(&:name)).to include(
          'new album name 1', 'new album name 2'
        )
        expect(band.albums.map(&:id)).not_to include(
          album_ids.first, album_ids.last
        )
      end
    end

    describe "when it can't update the band" do
      it 'raises an error' do
        new_attrs = {
          id: band.id,
          name: 'new name',
          remove_album_ids: [ 150 ]
        }

        expect {
          use_case.call(new_attrs)
        }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end
end
