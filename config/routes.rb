Rails.application.routes.draw do
  get 'rooms/create'
  get 'rooms/show'
  devise_for :users

  resources :users, :only => [:show, :edit, :update, :index, :destroy] do
    get :followings, :followers
  end

  resources :books, :only => [:create, :show, :edit, :update, :index, :destroy] do
    resources :likes, :only => [:create, :destroy]
    resources :comments, :only => [:create, :destroy]
  end

  resources :relationships, :only => [:create, :destroy]
  resources :rooms, :only => [:create, :show]
  resources :messages, :only => [:create]
  root 'home#top'
  get 'home/about'
  get '/search' => 'search#search'

  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
