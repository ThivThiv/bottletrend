Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'batches/:id', to: 'batches#show', as: 'bottle'
  get 'collection', to: 'pages#collection'
  get "domains/:id", to:"domains#show", as: "domain"
  get "batches", to:"batches#index"
  get "domains", to:"domains#index"

  resources :batches do
    resources :transactions, only: [:new, :create]
  end
  # post
end
