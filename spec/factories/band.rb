FactoryBot.define do
  factory :band, class: 'Band' do
    sequence(:name) { |i| "Band#{i}" }
    bio 'Mysterious Ways'

    transient do
      songs_count 3
    end

    trait :with_songs do
      after(:build) do |band, attr|
        attr.songs = build_list(
          :song, attr.songs_count,
          artist: band
        )
      end
    end

    transient do
      albums_count 3
    end

    trait :with_albums do
      after(:build) do |band, attr|
        attr.albums = build_list(
          :album, attr.albums_count,
          artist: band
        )
      end
    end

    factory :band_with_songs, traits: [:with_songs]
    factory :band_with_albums, traits: [:with_albums]
  end
end
