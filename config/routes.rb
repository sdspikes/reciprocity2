Rails.application.routes.draw do
  resources :activities
  resources :connection_requests
  resources :connections
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :categories
  resources :checks

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'checks#index'
end
