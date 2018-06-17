FactoryBot.define do
  factory :playlist do
    sequence(:name) { |i| "Playlist#{i}" }

    transient do
      songs_count 3
    end

    trait :with_songs do
      after(:create) do |playlist, attr|
        playlist.songs = create_list(:song, attr.songs_count)
      end
    end

    factory :playlist_with_songs, traits: [:with_songs]
  end
end
