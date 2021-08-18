FactoryBot.define do
  factory :movie, class: 'Movie' do
    title { 'Autobiography' }
    description { 'Best description' }
    director { 'Me, Mario' }
    length { 125 }
    genre { 'comedy' }
  end
end
