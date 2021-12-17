Rails.application.routes.draw do
  get 'errors/not_found'
  devise_for :users
  resources :person, only: [:create, :new, :index, :destroy, :edit, :update]
  resources :category, only: [:destroy]
  resources :money_transaction, only: [:destroy]
  post '/person/new', to: 'person#create'

  post '/person/:id/edit', to: 'person#update'

  root 'home#index'

  get '/person/:id/categories', to: 'person#categories_index'

  match '/404', to: 'errors#not_found', via: :all

  get '/categories', to: 'category#index'

  get '/categories/:id/edit', to: 'category#edit'
  post '/categories/:id/edit', to: 'category#update'

  get '/categories/new', to: 'category#new'
  post '/categories/new', to: 'category#create'

  get '/transactions', to: 'money_transaction#index'

  get '/transactions/new', to: 'money_transaction#new'
  post '/transactions/new', to: 'money_transaction#create'

  get '/transactions/:id/edit', to: 'money_transaction#edit'
  post '/transactions/:id/edit', to: 'money_transaction#update'

  get '/categories/:id', to: 'category#info', as: 'category_info'
end
