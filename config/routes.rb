Rails.application.routes.draw do
  root 'homes#index'

  get '/missions', to: "static_pages#index"
  get '/missions/new', to: "static_pages#index"
  get '/missions/:id', to: "static_pages#index"

  devise_for :users, :controllers => {
    :omniauth_callbacks => "users/omniauth_callbacks",
    :registrations => "users/registrations"
  }

  namespace :api do
    namespace :v1 do
      resources :missions, only: [:index, :show, :create]
    end
  end

  resources :missions, only: [:new, :create, :show, :update, :destroy]
  resources :users, only: [:index, :show, :update, :destroy]
end
