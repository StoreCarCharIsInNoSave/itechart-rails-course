Rails.application.routes.draw do
  get 'errors/not_found'
  devise_for :users
  resources :person, only: [:create, :new, :index, :destroy, :edit, :update]

  post '/person/new', to: 'person#create'
  post '/person/:id/edit', to: 'person#update'

  root 'home#index'

  match '/404', to: 'errors#not_found', via: :all

end
