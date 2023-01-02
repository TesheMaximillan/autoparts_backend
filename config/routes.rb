Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      resources :categories, only: [:index, :create, :show, :update, :destroy]
      resources :products, only: [:index, :show, :create, :update, :destroy]
      resources :customers, only: [:index, :show, :create, :update, :destroy]
      resources :vendors, only: [:index, :show, :create, :update, :destroy]
      resources :stocks, only: [:index, :show, :create, :update, :destroy]
      resources :transfers, only: [:index, :create, :update, :destroy]
      resources :sales_transactions, only: [:index, :create, :show, :update, :destroy]
      resources :purchase_transactions, only: [:index, :create, :show, :update, :destroy]
      resources :sales, only: [:create, :update, :destroy]
      resources :purchases, only: [:create, :update, :destroy]
      resources :sessions, only: [:create]
      resources :registrations, only: [:create]
      resources :settings, only: [:index, :create, :update]
      delete :logout, to: "sessions#logout"
      get :logged_in, to: "sessions#logged_in"
      get :stocks_products, to: "stocks#stocks_products"
    end
  end
end
