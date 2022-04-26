Rails.application.routes.draw do
  get 'weapons/index'
  get 'weapons/create'
  get 'weapons/destroy'
  get 'weapons/show'

  get 'enemies/index'
  get 'enemies/create'
  get 'enemies/destroy'
  get 'enemies/show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :weapons, only: [:index, :create, :destroy, :show]
  resources :enemies, only: [:index, :show, :create,:update, :destroy]
end
