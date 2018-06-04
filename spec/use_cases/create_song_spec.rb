require 'spec_helper'
require_relative '../../app/use_cases/create_song'

module MusicAPI
  RSpec.describe UseCases::CreateSong do
    let(:model_class) { double }
    let(:artist_class) { double }
    let(:album_class) { double }
    let(:use_case) { described_class.new(model_class, artist_class, album_class) }

    context 'with a new artist' do
      context 'with a new album' do
        it 'creates a new song' do
          params = {
            song: {
              song_attributes: 'a new song',
              artist: { name:  'a new artist' },
              album: { name:  'a new album'}
            }
          }

          allow(model_class).to receive(:transaction).and_yield

          expect(artist_class).to receive(:create!).with(name: 'a new artist')
            .and_return(name: 'a created artist')

          expect(album_class).to receive(:create!).with(
            name: 'a new album', artist: { name: 'a created artist' }
          ).and_return(name: 'a created album')

          expect(model_class).to receive(:create!).with(
            song_attributes: 'a new song',
            artist: { name: 'a created artist' },
            album: { name: 'a created album' }
          )

          described_class.new(model_class, artist_class, album_class).call(params)
        end
      end

      context 'with a persisted album' do
        it 'creates a new song' do
          params = {
            song: {
              song_attributes: 'a new song',
              artist: { name:  'a new artist' },
              album: { id:  444 }
            }
          }

          allow(model_class).to receive(:transaction).and_yield

          expect(artist_class).to receive(:create!).with(name: 'a new artist')
            .and_return(name: 'a created artist')

          expect(album_class).to receive(:find).with(444)
            .and_return(name: 'a persisted album')

          expect(model_class).to receive(:create!).with(
            song_attributes: 'a new song',
            artist: { name: 'a created artist' },
            album: { name: 'a persisted album' }
          )

          described_class.new(model_class, artist_class, album_class).call(params)
        end
      end

      context 'without an album' do
        it 'creates a new song' do
          params = {
            song: {
              song_attributes: 'a new song',
              artist: { name:  'a new artist' }
            }
          }

          allow(model_class).to receive(:transaction).and_yield

          expect(artist_class).to receive(:create!).with(name: 'a new artist')
            .and_return(name: 'a created artist')

          expect(model_class).to receive(:create!).with(
            song_attributes: 'a new song',
            artist: { name: 'a created artist' },
            album: nil
          )

          described_class.new(model_class, artist_class, album_class).call(params)
        end
      end
    end

    context 'with a persisted artist' do
      context 'with a new album' do
        it 'creates a new song' do
          params = {
            song: {
              song_attributes: 'a new song',
              artist: { id:  222 },
              album: { name:  'a new album'}
            }
          }

          allow(model_class).to receive(:transaction).and_yield

          expect(artist_class).to receive(:find).with(222)
            .and_return(id: 222, name: 'old artist')

          expect(album_class).to receive(:create!).with(
            name: 'a new album', artist: { id: 222, name: 'old artist' }
          ).and_return(name: 'a created album', artist_id: 222)

          expect(model_class).to receive(:create!).with(
            song_attributes: 'a new song',
            artist: { id:  222, name: 'old artist' },
            album: { name: 'a created album', artist_id: 222 }
          )

          described_class.new(model_class, artist_class, album_class).call(params)
        end
      end

      context 'with a persisted album' do
        it 'creates a song' do
          params = {
            song: {
              song_attributes: 'a new song',
              artist: { id:  222 },
              album: { id:  444 }
            }
          }

          allow(model_class).to receive(:transaction).and_yield

          expect(artist_class).to receive(:find).with(222)
            .and_return(id: 222, name: 'old artist')

          expect(album_class).to receive(:find).with(444)
            .and_return(id: 444, name: 'old album', artist_id: 222)

          expect(model_class).to receive(:create!).with(
            song_attributes: 'a new song',
            artist: { id:  222, name: 'old artist' },
            album: { id: 444, name: 'old album', artist_id: 222 }
          )

          described_class.new(model_class, artist_class, album_class).call(params)
        end
      end

      context 'without an album' do
        it 'creates a song' do
          params = {
            song: {
              song_attributes: 'a new song',
              artist: { id:  222 }
            }
          }

          allow(model_class).to receive(:transaction).and_yield

          expect(artist_class).to receive(:find).with(222)
            .and_return(id: 222, name: 'old artist')

          expect(model_class).to receive(:create!).with(
            song_attributes: 'a new song',
            artist: { id:  222, name: 'old artist' },
            album: nil
          )

          described_class.new(model_class, artist_class, album_class).call(params)
        end
      end
    end

    context 'with inconsistences between artist and album' do
      it 'raise an error if album does not belong to artist' do
        params = {
          song: {
            song_attributes: 'a new song',
            artist: { id:  222 },
            album: { id:  444 }
          }
        }

        allow(model_class).to receive(:transaction).and_yield

        expect(artist_class).to receive(:find).with(222)
          .and_return(id: 222, name: 'old artist')

        expect(album_class).to receive(:find).with(444)
          .and_return(id: 444, name: 'old album', artist_id: 333)

        expect {
          described_class.new(model_class, artist_class, album_class).call(params)
        }.to raise_exception(UseCases::InconsistentData)
      end
    end
  end
end
