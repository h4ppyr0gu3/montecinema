Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :movies, only: %i[index show create destroy show]
      resources :screenings, only: %i[index show create destroy show]
      resources :cinemas, only: %i[index show create destroy show]
      namespace :users do
        # resources :passwords
        resources :registrations, only: %i[create update show destroy]
        resources :sessions, only: %i[create destroy]
      end
    end
  end
end
