Rails.application.routes.draw do
  get 'weapons/index'
  post 'weapons/create'
  get 'weapons/destroy'

  get 'enemies/index'
  post 'enemies/create'
  get 'enemies/destroy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :weapons, only: [:index, :create, :destroy, :show]
  resources :enemies, only: [:index, :create,:update, :destroy, :show]
end
