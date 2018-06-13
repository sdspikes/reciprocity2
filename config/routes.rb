Rails.application.routes.draw do
  resources :activities do
    resources :users do
      resources :checks, only: [:create]
    end
  end
  resources :connection_requests
  resources :connections
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :categories
  resources :checks, only: [:index, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'checks#index'
end
