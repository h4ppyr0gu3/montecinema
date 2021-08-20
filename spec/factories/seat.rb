FactoryBot.define do
  factory :seat, class: 'Seat' do
    association :cinema # , factory: :cinema
    sequence(:seat_number) { |n| "seat_number #{n}" }
  end
end
