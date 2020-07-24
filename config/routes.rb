Rails.application.routes.draw do
  # デプロイ作業に必要なルーティング
  root "items#index"
  resources :posts, only: [:index]
  resources :items do
    collection do
      get 'test'
    end
  end
  resources :users do
    collection do
      get 'login'
      get 'new'
    end
  end
end
