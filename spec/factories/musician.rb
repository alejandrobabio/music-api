FactoryBot.define do
  factory :musician, class: 'Musician' do
    sequence(:name) { |i| "Musician#{i}" }
    bio '- Bono, please, say something. - Something'
    type 'Musician'
  end
end
