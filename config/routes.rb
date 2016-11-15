Rails.application.routes.draw do
  get 'tags/index'

  root 'questions#index'
  resources :questions do
  	resources :answers, only: [:create, :edit, :update, :destroy] do
  	  resources :votes, only: [:create, :update, :destroy]
  	end
    resources :votes, only: [:create, :update, :destroy]
  	resources :favorites, only: [:create, :destroy]
  end
  devise_for :users
  resources :users, :only => [:index, :show]
end
