Rails.application.routes.draw do
  get 'users/index'

  get 'users/show'

  root 'questions#index'
  resources :questions do
  	resources :answer, only: [:create, :edit, :update, :destroy]
  end
  devise_for :users
  resources :users, :only => [:index, :show]
end
