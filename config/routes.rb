Rails.application.routes.draw do
  resources :profile_items
  resources :profile_item_categories
  resources :privacy_group_members
  resources :privacy_groups
  resources :seekings
  get 'compatibilities/unrated', :to => 'compatibilities#unrated_index'
  get 'compatibilities/rated', :to => 'compatibilities#rated_index'
  get 'compatibilities/dealbreakers', :to => 'compatibilities#dealbreakers_index'
  resources :compatibilities
  resources :match_people
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
  resources :profiles

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # root 'compatibilities#index'
  root 'checks#index'
end
