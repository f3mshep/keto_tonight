Rails.application.routes.draw do
  get '/users/home' => 'users#home', as: "user_home"
  get '/users/:id/my_likes' => 'recipes#my_likes', as: "my_likes"
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root 'static#home'
  patch '/users/:user_id/pantry' => 'pantries#update', as: 'user_pantry_update'
  post '/recipes/:recipe_id/comments' => 'comments#create', as: "create_recipe_comment"
  resources :users do
    resource :pantry
    resources :recipes
  end
  resources :recipes, only: [:update, :create, :destroy, :index]
  get '/recipes/search' => 'recipes#search', as: "search"
  resources :comments, only: [:destroy, :update]
  get '/recipes/:id/missing_ingredients/:user_id' => 'recipes#missing_ingredients'
  resources :pantry_ingredients
  resources :ingredients
  resources :recipe_ingredients
  resources :categories
  resources :users
  resources :likes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
