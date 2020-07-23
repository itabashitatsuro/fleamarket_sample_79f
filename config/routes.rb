Rails.application.routes.draw do
  root "posts#index"
  resources :posts, only: [:index]
  resources :users do
    collection do
      get 'login'
      get 'new'
    end
  end
end
