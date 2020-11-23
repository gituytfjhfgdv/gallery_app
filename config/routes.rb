Rails.application.routes.draw do
  root to: 'sessions#new'
  get 'login',  to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  resources :photos, only: %i[index new create]

  get '/oauth/callback', to: 'o_authes#create'
  post 'tweet/:photo_id', to: 'o_authes#tweet', as: :new_tweet
end
