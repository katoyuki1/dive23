Rails.application.routes.draw do
  root 'questions#index'
  resources :questions do
  	resources :answers, only: [:create, :edit, :update, :destroy]
  	resources :favorites, only: [:create, :destroy]
  end
  devise_for :users
end
