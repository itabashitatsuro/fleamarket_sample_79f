Rails.application.routes.draw do
  root "items#index"
  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :addresses, only: [:new, :create, :edit, :update, :destory]
  resources :credit_cards, only: [:new, :create, :destroy, :show]
  resources :posts, only: [:index]
  resources :users do
    collection do
      get 'login'
    end
  end
  
  resources :items do
    collection do
      get 'category/get_category_children', to: 'items#get_category_children', defaults: { format: 'json' }
      get 'category/get_category_grandchildren', to: 'items#get_category_grandchildren', defaults: { format: 'json' }
      get 'list'
    end
    member do
      get 'purchase'
      post 'pay'
    end
  end
  
  # resources :items do
  #   collection do
  #     get 'test'
  #     get 'login'
  #     get 'new'
  #     get 'purchase'
  #     get 'pay'
  #     get 'category/get_category_children', to: 'items#get_category_children', defaults: { format: 'json' }
  #     get 'category/get_category_grandchildren',
  #   end
  # end
end
