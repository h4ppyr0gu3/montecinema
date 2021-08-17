FactoryBot.define do
  factory :cinema, class: 'Cinema' do
    sequence(:cinema_number)
    total_seats { 25 }

    # after(:create) do |cinema|
    #   create(:seat, cinema: cinema)
    # end
  end
end
