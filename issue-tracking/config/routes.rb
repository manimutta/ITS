Rails.application.routes.draw do
  get 'home/index'
  root 'tickets#index'
  resources :tickets

  resources :comments, only: [:create, :destroy]
  
  get 'users/edit_user' => 'users#edit_user'
  devise_for :users
  resources :users, except: [:new,:create, :destroy]
end
