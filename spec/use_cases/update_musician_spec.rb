require 'db_helper'

module MusicAPI
  RSpec.describe UseCases::UpdateMusician do
    let(:model_class) { Musician }
    let(:use_case) { described_class.new(model_class) }

    let(:musician) { create :musician_with_albums }

    describe 'when updates the musician' do
      it "updates musician's attributes" do
        album_ids = musician.albums.map(&:id)
        new_attrs = {
          id: musician.id,
          name: 'new name',
          bio: 'new bio',
          new_albums: [
            { name: 'new album name 1' },
            { name: 'new album name 2' }
          ],
          remove_album_ids: [ album_ids.first, album_ids.last ]
        }
        use_case.call(new_attrs)
        musician.reload

        expect(musician.name).to eq 'new name'
        expect(musician.bio).to eq 'new bio'
        expect(musician.albums.map(&:name)).to include(
          'new album name 1', 'new album name 2'
        )
        expect(musician.albums.map(&:id)).not_to include(
          album_ids.first, album_ids.last
        )
      end
    end

    describe "when it can't update the musician" do
      it 'raises an error' do
        new_attrs = {
          id: musician.id,
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
