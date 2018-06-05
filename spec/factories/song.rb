FactoryBot.define do
  factory :song do
    name 'Where the streets has no name'
    duration 336
    genre 'Rock'
    version 'Album'
    after(:build) do |song, attr|
      band = build :band, songs: [song]
      attr.artist = band
      attr.artist_type = 'Band'
      attr.album = build :album, artist: band, artist_type: 'Band'
    end
  end
end
