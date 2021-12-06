Rails.application.routes.draw do
  devise_for :users
  resources :person, only: [:create, :new, :index, :destroy]

  post '/person/new', to: 'person#create'

  root 'home#index'

end
