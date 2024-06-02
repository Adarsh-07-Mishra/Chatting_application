Rails.application.routes.draw do
  get 'rooms/index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy'

  # resources :rooms
  resources :users
  root 'rooms#index'
  resources :rooms do
    resources :messages
  end
end
