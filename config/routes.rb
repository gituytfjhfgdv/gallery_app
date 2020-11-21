Rails.application.routes.draw do
  resources :photos, only: %i[index new create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'login',  to: 'sessions#new'
  post 'login', to: 'sessions#create'
end
