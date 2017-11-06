Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root 'static#home'

  resources :users do
    resource :pantry
  end
  resources :pantry_ingredients
  resources :ingredients
  resources :recipe_ingredients
  resources :recipes
  resources :categories
  resources :comments
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
