FactoryBot.define do
  factory :user do
    first_name { 'David' }
    last_name  { 'Rogers' }
    email { 'test@test.com' }
    password { 'test123' }

    trait :admin do
      role { 2 }
    end

    trait :teller do
      role { 1 }
    end
  end
end
