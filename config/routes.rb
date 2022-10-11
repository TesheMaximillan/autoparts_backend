Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      resources :categories do
        resources :products, only: [:index, :create, :update, :destroy]
      end
      resources :sales, only: [:index, :create, :show, :update, :destroy]
      resources :purchases, only: [:index, :create, :show, :update, :destroy]
      resources :sessions, only: [:create]
      resources :registrations, only: [:create]
      delete :logout, to: "sessions#logout"
      get :logged_in, to: "sessions#logged_in"
    end
  end
end
