Rails.application.routes.draw do
  devise_for :users

  resources :campaigns, only: :show
  resources :line_items, only: :index

  root 'line_items#index'
end
