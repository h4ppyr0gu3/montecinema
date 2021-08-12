# frozen_string_literal: true

Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    scope :v1 do
      devise_for :users
    end
  end

  namespace :api do
    namespace :v1 do
      resources :movies, only: %i[index show create destroy show]
      resources :screenings, only: %i[index show create destroy show]
      resources :cinemas, only: %i[index show create destroy show]
    end
  end
end
