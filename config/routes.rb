Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  mount_devise_token_auth_for 'Users::Model', at: '/api/v1/users', controllers: {
    registrations: 'api/v1/override/registrations',
    sessions: 'api/v1/override/sessions'
  }
  namespace :api do
    namespace :v1 do
      resources :movies, only: %i[index show create destroy update]
      resources :screenings, only: %i[index show create destroy update]
      resources :cinemas, only: %i[update create destroy show]
      resources :reservations, only: %i[index show create destroy update]
      resources :vouchers, only: %i[index show create update]
      post 'vouchers/purchase', to: 'vouchers#purchase'
      post 'vouchers/redeem', to: 'vouchers#redeem'
    end
  end
end
