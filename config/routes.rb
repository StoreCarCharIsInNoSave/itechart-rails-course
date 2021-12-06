Rails.application.routes.draw do
  devise_for :users
  resources :person, only: [:create, :new, :index, :destroy, :edit, :update]

  post '/person/new', to: 'person#create'
  post '/person/:id/edit', to: 'person#update'

  root 'home#index'

end
