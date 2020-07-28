Rails.application.routes.draw do
<<<<<<< Updated upstream
  # デプロイ作業に必要なルーティング
  root "posts#index"
  resources :posts, only: [:index]
  resources :items, only: [:index, :new]
end
  resources :users do
=======
  root "items#index"
  resources :posts, only: [:index]
  resources :addresses, only: [:new, :create, :edit, :update, :destory]
  resources :credit_cards, only: [:new, :create, :destroy, :show]
  resources :users do
    collection do
      get 'login'
    end
  end
  
  resources :items, only: [:index, :new] do
    collection do
      get 'test'
    end
  end
  resources :items do
>>>>>>> Stashed changes
    collection do
      get 'login'
      get 'new'
    end
  end
end
