FactoryBot.define do
  factory :user do
    first_name { 'David' }
    last_name  { 'Rogers' }
    email { 'test@test.com' }
    password { 'test123' }

    trait :client do
    end

    trait :admin do
    end

    trait :teller do
    end
  end
end
