Rails.application.routes.draw do
  root 'questions#index'
  resources :questions do
  	resources :answer, only: [:create, :update, :destroy]
  end
  devise_for :users
end
