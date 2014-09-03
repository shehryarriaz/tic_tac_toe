TictactoeApp::Application.routes.draw do

  root to: 'sessions#new'

  resources :sessions
  resources :users
  resources :games

  post 'games/:id/make_move/:space', to: 'games#make_move', as: 'make_move'
  get 'logout', to: 'sessions#destroy', as: 'logout'
end
