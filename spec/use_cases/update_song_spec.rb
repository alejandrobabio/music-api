require 'db_helper'

module MusicAPI
  RSpec.describe UseCases::UpdateSong do
    let(:model_class) { Song }
    let(:artist_class) { Musician }
    let(:album_class) { Album }
    let(:use_case) { described_class.new(model_class, artist_class, album_class) }

    let(:song) { create :song }

    describe 'when updates the song' do
      it "updates song's attributes" do
        new_attrs = {
          id: song.id,
          name: 'new name',
          duration: 222,
          genre: 'Folk',
          version: 'Best B sides',
        }
        use_case.call(new_attrs)
        song.reload

        expect(song.name).to eq 'new name'
        expect(song.duration).to eq 222
        expect(song.genre).to eq 'Folk'
        expect(song.version).to eq 'Best B sides'
      end
    end
  end
end
