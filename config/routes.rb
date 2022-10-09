Rails.application.routes.draw do
  namespace :public do
    resources :orders,only: [:new, :index, :show]
  end
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
    resources :orders,only: [:show]
    resources :order_details,only: [:update]

  end
  scope module: :public do
  root to: "homes#top"
  get "/homes/about"=>"homes#about",as:"about"
  end
  scope module: :admin do
  get '/admin' => 'homes#top'
  end

end