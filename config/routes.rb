Rails.application.routes.draw do
  devise_for :users

  resources :line_items, only: :index

  root 'line_items#index'
end
