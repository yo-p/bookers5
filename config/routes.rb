Rails.application.routes.draw do
  devise_for :users
  resources :users, :only => [:show, :edit, :update, :index, :destroy]
  resources :books, :only => [:create, :show, :edit, :update, :index, :destroy] do
    resources :likes, :only => [:create, :destroy]
    resources :comments, :only => [:create, :destroy]
  end
  root 'home#top'
  get 'home/about'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
