Rails.application.routes.draw do
  devise_for :users
  
  root 'runnings#index'
  resources :events, only: [:index, :new, :create]
  resources :runnings, only: [:index, :create]
  get 'runnings/json_index', to: 'runnings#json_index'
end