FactoryBot.define do
  factory :song do
    sequence(:name) { |i| "Song#{i}" }
    duration 336
    genre 'Rock'
    version 'Album'
    after(:build) do |song, attr|
      unless song.artist
        band = build :band, songs: [song]
        attr.artist = band
      end
    end

    trait :with_album do
      after(:build) do |song, attr|
        attr.album = build :album, artist: song.artist
      end
    end

    factory :song_with_album, traits: [:with_album]
  end
end
