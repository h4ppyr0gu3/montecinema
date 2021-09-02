FactoryBot.define do
  factory :voucher, class: 'Vouchers::Model' do
    expiration_date { Date.today + 2.days }
    description  { 'Rogers' }
    value { 10 }
    points_required { 10 }
    sequence(:code) { |n| "#{n}" }
  end
end
