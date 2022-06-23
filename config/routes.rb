Rails.application.routes.draw do
  get 'errors/not_found'
  get 'errors/internal_server_error'
  devise_for :users
  root to: 'pages#home'
  get 'batches/:id', to: 'batches#show', as: 'bottle'
  get 'collection', to: 'pages#collection'
  get "domains/:id", to: "domains#show", as: "domain"
  get "batches", to: "batches#index"
  get "domains", to: "domains#index"
  get 'trade', to: 'pages#trade'

  resources :batches do
    resources :transactions, only: [:new, :create]
    get "resale", to: "transactions#resale"
    post "resale", to: "transactions#create_resale"
  end
end
