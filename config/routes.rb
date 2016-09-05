require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web, at: '/sidekiq'
  resources :links, only: [:index, :new, :create, :destroy]
  root to: 'links#index'
end
