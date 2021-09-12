FactoryBot.define do
  factory :voucher, class: 'Vouchers::Model' do
    expiration_date { Date.today + 2.days }
    description { 'Rogers' }
    points_required { 10 }
    sequence(:code, &:to_s)
  end
end
