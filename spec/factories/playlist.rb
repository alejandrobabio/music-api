FactoryBot.define do
  factory :playlist do
    sequence(:name) { |i| "Playlist#{i}" }
  end
end
