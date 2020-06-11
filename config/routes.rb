Rails.application.routes.draw do
  root 'homes#index'

  get '/test', to: "homes#show"

  devise_for :users, :controllers => {
    :omniauth_callbacks => "users/omniauth_callbacks",
    :registrations => "users/registrations"
  }

  resources :missions
  resources :users, only: [:index, :show, :update, :destroy]
end
