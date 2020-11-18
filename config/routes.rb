Rails.application.routes.draw do
  devise_for :users

  resources :campaigns, only: %i[index show]
  resources :line_items, only: %i[index update]

  root 'line_items#index'
end
