Rails.application.routes.draw do
  
  get "/login", to: "sessions#new"
  get "/logout", to: "sessions#destroy"
  get 'events/index'
  get 'events/show'
  get 'events/new'
  get 'events/edit'
  get 'users/index'
  get 'users/show'
  get 'signup', to: "users#new"
  get 'users/edit'

  resources :users
  resources :events
  resources :sessions, only: [:new, :create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
