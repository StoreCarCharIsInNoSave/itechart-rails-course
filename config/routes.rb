Rails.application.routes.draw do
  devise_for :users
  resources :person, only: [:index,:destroy]
  root 'home#index'


end
