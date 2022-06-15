Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'batches/:id', to: 'batches#show', as: 'bottle'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
