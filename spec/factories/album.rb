FactoryBot.define do
  factory :album do
    sequence(:name) { |i| "Album#{i}" }
  end
end
