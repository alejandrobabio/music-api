FactoryBot.define do
  factory :photo do
    sequence(:title) { |i| "Photo#{i}" }
  end
end
