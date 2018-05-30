FactoryBot.define do
  factory :band do
    name { Faker::Name.name }
    bio { Faker::Lorem.paragraph(2) }
  end
end
