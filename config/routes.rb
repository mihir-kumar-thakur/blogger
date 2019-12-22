Rails.application.routes.draw do
  root "home#index"

  devise_for :users
  resources :posts do
    resource :like, only: [:create, :destroy]
    resources :comments
  end
end
