Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  get 'home/top'
  namespace :admin do
    root to:'homes#top'
    resources :genres,only: [:new, :index, :edit, :create, :update]
    resources :items,only: [:index, :new, :create, :show, :edit, :update]
    resources :customers,only: [:index, :show, :edit, :update]
    resources :orders,only: [:show]
    resources :order_details,only: [:update]
    get '/admin/sign_out' => 'admin/sessions#destroy'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
