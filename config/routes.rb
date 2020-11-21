Rails.application.routes.draw do
  devise_for :users

  resources :campaigns, only: %i[index show] do
    member do
      patch :update_status
    end
  end

  resources :line_items, only: %i[index update show] do
    member do
      patch :update_status
    end
  end

  resources :invoices, only: %i[index create show update] do
    member do
      get :upload
      delete :remove_campaign
    end
  end

  resources :versions, only: %i[index show]

  root 'line_items#index'
end
