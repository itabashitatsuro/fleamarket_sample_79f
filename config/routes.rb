Rails.application.routes.draw do
  # devise_for :users  
  devise_for :users, controllers: { registrations: 'users/registrations' }


  root "items#index"
  resources :posts, only: [:index]
  resources :addresses, only: [:new, :create, :edit, :update, :destory]
  resources :credit_cards, only: [:new, :create, :destroy, :show]
  resources :users

  resources :items, only: [:index, :new] do
    collection do
      get 'login'
      get 'new'
      get 'purchase'
    end
  end
end
