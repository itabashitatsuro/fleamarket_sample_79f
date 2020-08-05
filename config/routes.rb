Rails.application.routes.draw do
  # devise_for :users  
  # devise_for :users, controllers: { registrations: 'users/registrations' }

  root "items#index"
  resources :addresses, only: [:new, :create, :edit, :update, :destory]
  resources :credit_cards, only: [:new, :create, :destroy, :show]

  resources :users do
    collection do
      get 'login'
    end
  end
  
  resources :items do
    collection do
      get 'category/get_category_children', to: 'items#get_category_children', defaults: { format: 'json' }
      get 'category/get_category_grandchildren', to: 'items#get_category_grandchildren', defaults: { format: 'json' }
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
