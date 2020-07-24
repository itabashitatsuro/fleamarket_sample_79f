Rails.application.routes.draw do
  # デプロイ作業に必要なルーティング
  # root 'items#index'
  root "posts#index"
  resources :posts, only: [:index]
  resources :users, only: [:new, :create, :edit, :update, :show]
  resources :credit_cards, only: [:new, :create, :show, :destroy]
end