FactoryBot.define do
  factory :cinema, class: 'Cinemas::Model' do
    sequence(:cinema_number) { |n| n }
    rows { 5 }
    columns { 5 }
  end
end
