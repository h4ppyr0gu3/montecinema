Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :movies, only: %i[index show create destroy show]
      resources :screenings, only: %i[index show create destroy show]
      resources :cinemas, only: %i[index show create destroy show]
      namespace :users do
        resources :passwords 
        resources :registrations
        resources :sessions
      end
    end
  end
end
