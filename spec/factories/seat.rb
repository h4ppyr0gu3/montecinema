FactoryBot.define do
  factory :seat, class: 'Seats::Model' do
    sequence(:seat_number, &:to_s)
    sequence(:name, &:to_s)
    association :cinema
  end
end
