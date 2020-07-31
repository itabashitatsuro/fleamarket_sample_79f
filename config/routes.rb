Rails.application.routes.draw do
  root "items#index"
  resources :posts, only: [:index]
  resources :addresses, only: [:new, :create, :edit, :update, :destory]
  resources :credit_cards, only: [:new, :create, :destroy, :show]
  resources :users do
    collection do
      get 'login'
    end
  end
  
  resources :items do
    collection do
      get 'test'
      get 'login'
      get 'new'
      get 'purchase'
    end
  end
end