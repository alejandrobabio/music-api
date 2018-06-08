FactoryBot.define do
  factory :play_list do
    sequence(:name) { |i| "PlayList#{i}" }
  end
end
