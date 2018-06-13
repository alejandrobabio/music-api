FactoryBot.define do
  factory :musician, class: 'Musician' do
    sequence(:name) { |i| "Musician#{i}" }
    bio '- Bono, please, say something. - Something'
    type 'Musician'

    transient do
      songs_count 3
    end

    trait :with_songs do
      after(:build) do |musician, attr|
        attr.songs = build_list(
          :song, attr.songs_count,
          artist: musician,
          artist_type: attr.type
        )
      end
    end

    factory :musician_with_songs, traits: [:with_songs]
  end
end
