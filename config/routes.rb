Rails.application.routes.draw do
  root 'questions#index'
  resources :questions do
  	resources :answer, only: [:create, :edit, :update, :destroy]
  end
  devise_for :users
end
