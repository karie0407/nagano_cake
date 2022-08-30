Rails.application.routes.draw do
  devise_for :admins
  namespace :admin do
    root to:'homes#top'
    resources :genres,only: [:new, :index, :edit]
    resources :items,only: [:index, :new, :create, :show, :edit, :update]
    resources :customers,only: [:index, :show, :edit, :update]
    resources :orders,only: [:show]
    resources :order_details,only: [:update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
