FactoryBot.define do
  factory :musician do
    sequence(:name) { |i| "Musician#{i}" }
    bio '- Bono, please, say something. - Something'
  end
end
