Rails.application.routes.draw do
  # デプロイ作業に必要なルーティング
  root 'items#index'
  # root "posts#index"
  resources :posts, only: [:index]
end