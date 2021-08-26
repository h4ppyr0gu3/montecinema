FactoryBot.define do
  factory :seat, class: 'Seats::Model' do
    sequence(:seat_number) { |n| "#{n}" }
    sequence(:name) { |n| "#{n}" }
    association :cinema
  end
end
