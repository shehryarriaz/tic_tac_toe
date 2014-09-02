TictactoeApp::Application.routes.draw do
  get "sessions/new"

  get "sessions/create"

  get "sessions/destroy"

  root to: 'sessions#new'

  resources :users
  resources :sessions
  get 'logout', to: 'sessions#destroy', as: 'logout'
end
