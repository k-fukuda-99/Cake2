Rails.application.routes.draw do
# 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# scope module URLを変えない/ファイル構成だけ指定のパスにする
scope module: :public do
  root to: "homes#top"
  get "/about" => "homes#about"
  resources :items, only: [:index, :show]
  resource :customers, only: [:show, :edit, :update]
  get "/customers/unsubscribe" => "customers#unsubscribe"
  patch "/customers/withdraw" => "customers#withdraw"
  resources :cart_items, only: [:index, :update, :destroy, :create]
  delete "/cart_items/destroy_all" => "cart_items#destroy_all"
  resources :orders, only: [:new, :create, :show, :index]
  post "/orders/confirm" => "orders#confirm"
  get "/orders/complete" => "orders#complete"
  resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  get "/search" => "items#search"

end

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}
namespace :admin do
  get '/' => "homes#top"
  resources :items, only: [:index, :new, :create, :show, :edit, :update]
  resources :genres, only: [:index, :create, :edit, :update]
  resources :customers, only: [:index, :show, :edit, :update]
  resources :orders, only: [:show, :update]
  resources :order_details, only:[:update]
  get "/search" => "items#search"

end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
