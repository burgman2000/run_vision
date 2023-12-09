Rails.application.routes.draw do
  
  root 'runnings#index'
  resources :runnings, only: [:index, :create]
  get 'runnings/json_index', to: 'runnings#json_index'
end