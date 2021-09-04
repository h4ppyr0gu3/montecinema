FactoryBot.define do
  factory :user, class: 'Users::Model' do
    first_name { 'David' }
    last_name  { 'Rogers' }
    email { 'test@test.com' }
    password { 'test123' }
    points_earned { 0 }
    points_redeemed { 0 }

    trait :admin do
      role { 2 }
    end

    trait :support do
      role { 1 }
    end
  end
end
