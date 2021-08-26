FactoryBot.define do
  factory :screening, class: 'Screenings::Model' do
    association :movie
    association :cinema
    airing_time { Time.zone.now }
  end
end
