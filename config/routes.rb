Rails.application.routes.draw do
  root "posts#index"
  resources :posts, only: [:index]
  resources :addresses, only: [:new, :create, :edit, :update, :destory]
  resources :credit_cards, only: [:new, :create, :destroy, :show]
  resources :users, only: [:new, :create, :edit, :update, :show]
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
    collection do
      get 'purchase'
    end
  end
end

