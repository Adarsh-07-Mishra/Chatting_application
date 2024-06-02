Rails.application.routes.draw do
  get 'rooms/index'
  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  # resources :rooms
  resources :users
  root 'rooms#index'
  resources :rooms do
    resources :messages
  end
end
