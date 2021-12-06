Rails.application.routes.draw do
  devise_for :users
  resources :person, only: [:create, :new, :index, :destroy]
  root 'home#index'

end
