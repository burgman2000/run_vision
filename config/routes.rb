Rails.application.routes.draw do
  devise_for :users

  root 'events#index'
  resources :events, only: [:index, :new, :create, :show, :edit, :update] do
    resources :runnings, only: [:new, :create, :edit, :update]
  end
  resources :runnings, only: [:index, :create]
  get 'runnings/json_index', to: 'runnings#json_index'
end