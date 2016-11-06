Rails.application.routes.draw do
  get 'users/index'

  get 'users/show'

  root 'questions#index'
  resources :questions do
  	resources :answers, only: [:create, :edit, :update, :destroy]
  	resources :favorites, only: [:create, :destroy]
  end
  devise_for :users
  resources :users, :only => [:index, :show]
end
