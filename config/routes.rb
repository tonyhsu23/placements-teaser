Rails.application.routes.draw do
  devise_for :users

  resources :campaigns, only: %i[index show]
  resources :line_items, only: %i[index update]
  resources :invoices, only: %i[index create show update] do
    member do
      delete :remove_campaign
    end
  end

  root 'line_items#index'
end
