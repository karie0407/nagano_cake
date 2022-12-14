Rails.application.routes.draw do
  devise_for :customers, skip: [:passwords],controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  namespace :admin do
    resources :genres,only: [:new, :index, :edit, :create, :update]
    resources :items,only: [:index, :new, :create, :show, :edit, :update]
    resources :customers,only: [:index, :show, :edit, :update]
    resources :orders,only: [:show, :update]
    resources :order_details,only: [:update]

  end
  
  scope module: :public do
  root to: "homes#top"
  get "/homes/about"=>"homes#about",as:"about"
  get '/customers/my_page' => "customers#show"
  get '/customers/information/edit' => "customers#edit"
  patch '/customers/information' => "customers#update"
  get '/customers/unsubscribe' => "customers#unsubscribe"
  patch '/customers/withdraw' => "customers#withdraw"
  delete '/cart_items/destroy_all' => "cart_items#destroy_all"
  post '/orders/confirm' => "orders#confirm"
  get '/orders/complete' => "orders#complete"
  get '/orders/history' => "orders#history"
  resources :addresses, only: [:create, :index, :edit, :update, :destroy]
  resources :items, only: [:index, :show]
  resources :cart_items,only: [:index, :update, :destroy, :create]
  resources :orders,only: [:index, :new, :create, :show]
  end
  scope module: :admin do
  get '/admin' => 'homes#top'
  end

end