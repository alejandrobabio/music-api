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

    factory :band_with_songs, traits: [:with_songs]
  end
end
