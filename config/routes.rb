Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :movies, only: %i[index show create destroy update]
      resources :screenings, only: %i[index show create destroy update]
      resources :cinemas, only: %i[update create destroy show]
      resources :reservations, only: %i[index show create destroy show]
      namespace :users do
        resources :registrations, only: %i[create update show destroy]
        resources :sessions, only: %i[create destroy]
      end
    end
  end
end
