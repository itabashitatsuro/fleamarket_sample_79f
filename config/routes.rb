Rails.application.routes.draw do
  # デプロイ作業に必要なルーティング
  root 'items#index'
  # root "posts#index"
  resources :posts, only: [:index]
  resources :items, only: [:index, :new]
end
  resources :users do
    collection do
      get 'login'
      get 'new'
    end
  end
end
