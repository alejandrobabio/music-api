FactoryBot.define do
  factory :album do
    sequence(:name) { |i| "Album#{i}" }

    transient do
      songs_count 3
    end

    trait :with_songs do
      after(:build) do |album, attr|
        attr.artist = build :musician
        attr.artist_type = 'Musician'
        attr.songs = build_list(
          :song, attr.songs_count,
          album: album,
          artist: album.artist,
          artist_type: attr.artist_type
        )
      end
    end

    factory :album_with_songs, traits: [:with_songs]
  end
end
