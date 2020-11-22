Rails.application.routes.draw do
  resources :photos, only: %i[index new create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'login',  to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  get '/oauth/callback', to: 'o_authes#create'
  post 'tweet/:photo_id', to: 'o_authes#tweet', as: :new_tweet
end
