Rails.application.routes.draw do
  root "homes#index"

  devise_for :users, :controllers => {
    :omniauth_callbacks => "users/omniauth_callbacks",
    :registrations => "users/registrations"
  }

  get "/missions", to: "static_pages#index"
  get "/missions/new", to: "static_pages#index"
  get "/missions/:id", to: "static_pages#index"
  get "/users/:id", to: "static_pages#index"

  namespace :api do
    namespace :v1 do
      resources :missions, only: [:index, :show, :create]
      resources :users, only: [:show]
    end
  end

  resources :missions, only: [:update, :destroy]
  resources :users, only: [:index, :update, :destroy]
end
