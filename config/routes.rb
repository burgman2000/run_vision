Rails.application.routes.draw do
  
  root 'runnings#index'
  resources :runnings, only: [:index, :create]
end
