Rails.application.routes.draw do
  resources :profile_items
  resources :profile_item_categories
  resources :privacy_group_members
  resources :privacy_groups
  resources :seekings
  # get 'compatibilities/unrated', :to => 'compatibilities#unrated_index'
  # get 'compatibilities/rated', :to => 'compatibilities#rated_index'
  # get 'compatibilities/dealbreakers', :to => 'compatibilities#dealbreakers_index'
  # resources :compatibilities
  # resources :match_people
  resources :activities do
    resources :users
  end
  resources :connection_requests
  resources :connections
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :categories
  resources :checks, only: [:create, :index]
  get "api/profile_item_categories/:id/options", to: "profile_item_categories#get_options", as: "get_options"
  put "api/profiles/update_item", to: "profiles#update_item", as: "update_item"
  put "api/checks/new", to: "checks#create_check", as: "create_check", defaults: { format: 'json' }
  delete "api/checks/delete", to: "checks#destroy_check", as: "destroy_check"
  resources :profiles

  resources :text_profile_item
  resources :gender
  resources :profile_item_responses

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # root 'compatibilities#index'
  root 'checks#index'
end
