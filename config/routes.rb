Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  post 'auth/signup', to: 'users#create'
  post 'auth/login', to: 'sessions#create'

  resources :goals, only: [:create, :update]
end
