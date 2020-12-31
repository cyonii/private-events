Rails.application.routes.draw do
  root "application#index"
  resources :users, only: [:new, :create, :show]
  resources :session, only: [:new, :create, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
