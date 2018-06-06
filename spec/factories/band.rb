FactoryBot.define do
  factory :band do
    sequence(:name) { |i| "Band#{i}" }
    bio 'Mysterious Ways'
    type 'Band'
  end
end
