Rails.application.routes.draw do
  root "posts#index"
  resources :posts, only: [:index]
  resources :credit_cards, only: [:new, :create, :destroy, :show]
  resources :users, only: [:new, :create, :edit, :update, :show]
    resources :users do
      collection do
        get 'login'
        get 'done'
      end
    end
  
  resources :items, only: [:index, :new] do
    collection do
      get 'login'
      get 'new'
    end
  end
end

