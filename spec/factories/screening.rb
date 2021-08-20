FactoryBot.define do
  factory :screening, class: 'Screening' do
    association :movie
    association :cinema
    airing_time { Time.zone.now }
  end
end
