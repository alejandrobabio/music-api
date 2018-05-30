FactoryBot.define do
  factory :musician do
    name { Faker::Name.name }
    bio { Faker::Lorem.paragraph(2) }
  end
end
