Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
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
  resources :room_creation_requests, only: [:create]

  get '/auth/:provider/callback', to: 'sessions#omniauth'
  post '/auth/:provider/callback', to: 'sessions#omniauth' # Optional: for button_to with method: :post
  get '/auth/failure', to: redirect('/login')

end
