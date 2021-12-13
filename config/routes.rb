Rails.application.routes.draw do
  get 'errors/not_found'
  devise_for :users
  resources :person, only: [:create, :new, :index, :destroy, :edit, :update]
  resources :category, only: [:destroy]
  post '/person/new', to: 'person#create'
  post '/person/:id/edit', to: 'person#update'

  root 'home#index'

  get '/person/:id/categories', to: 'person#categories_index'

  match '/404', to: 'errors#not_found', via: :all


  get '/categories', to: 'category#index'

  get '/categories/new', to: 'category#new'
  post '/categories/new', to: 'category#create'

end
