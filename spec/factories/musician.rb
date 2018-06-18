FactoryBot.define do
  factory :musician, class: 'Musician' do
    sequence(:name) { |i| "Musician#{i}" }
    bio '- Bono, please, say something. - Something'

    transient do
      songs_count 3
    end

    trait :with_songs do
      after(:build) do |musician, attr|
        attr.songs = build_list(
          :song, attr.songs_count,
          artist: musician
        )
      end
    end

    transient do
      albums_count 3
    end

    trait :with_albums do
      after(:build) do |musician, attr|
        attr.albums = build_list(
          :album, attr.albums_count,
          artist: musician
        )
      end
    end

    factory :musician_with_songs, traits: [:with_songs]
    factory :musician_with_albums, traits: [:with_albums]
  end
end
