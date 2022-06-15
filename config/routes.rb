Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'batches/:id', to: 'batches#show', as: 'bottle'
  get "batches", to:"batches#index"
  get "domains", to:"domains#index"
end
