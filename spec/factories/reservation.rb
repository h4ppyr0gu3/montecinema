FactoryBot.define do
  factory :reservation, class: 'Reservations::Model' do
    association :movie
    association :screening
    association :cinema
    association :user
  end
end
