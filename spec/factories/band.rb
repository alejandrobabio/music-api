FactoryBot.define do
  factory :band, class: 'Band' do
    sequence(:name) { |i| "Band#{i}" }
    bio 'Mysterious Ways'
    type 'Band'
  end
end
