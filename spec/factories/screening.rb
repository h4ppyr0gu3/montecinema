FactoryBot.define do
  factory :screening, class: 'Screening' do
    create(:movie)
    create(:cinema, cinema_number: 1)
  end
end
