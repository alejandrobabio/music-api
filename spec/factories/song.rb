FactoryBot.define do
  factory :song do
    sequence(:name) { |i| "Song#{i}" }
    duration 336
    genre 'Rock'
    version 'Album'
    after(:build) do |song, attr|
      band = build :band, songs: [song]
      attr.artist = band
      attr.artist_type = 'Band'
    end

    trait :with_album do
      after(:build) do |song, attr|
        attr.album = build :album, artist: song.artist, artist_type: 'Band'
      end
    end

    factory :song_with_album, traits: [:with_album]
  end
end
