Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root 'static#home'
  patch '/users/:user_id/pantry' => 'pantries#update', as: 'user_pantry_update'
  resources :users do
    resource :pantry
    resources :recipes
  end
  resources :recipes, only: [:update, :create, :destroy]
  resources :pantry_ingredients
  resources :ingredients
  resources :recipe_ingredients
  resources :categories
  resources :comments
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
