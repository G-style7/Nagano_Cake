Rails.application.routes.draw do

# 管理者用
# URL /admin/sign_in ...
  devise_for :admin,skip:[:registrations,:passwords],controllers:{
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  namespace :admin do

    root to: 'homes#top'

    resources :items ,only:[:index, :new, :create, :show, :edit, :update]

    resources :genres ,only:[:index, :create, :edit, :update]

    resources :customers ,only:[:index, :show, :edit, :update] #顧客一覧など

    resources :orders ,only:[:show, :update]

    patch '/orders/:order_id/order_details/:id' => 'order_details#update' #製作ステータスの更新　　もしくはネストはなくてもよい /admin/order_details/:id

  end

# 顧客用
# URL /customers/sign_in ...
  devise_for :customers,skip:[:passwords],controllers:{
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

    scope module: :public do

    root to: 'homes#top'
    get '/about' => 'homes#about' ,as: 'about'

    resources :items ,only:[:index, :show]

    get '/customers/my_page' => 'customers#show'
    get '/customers/information/edit' => 'customers#edit' #顧客の登録情報編集画面
    patch 'customers/information' => 'customers#update' #顧客の登録情報更新
    get '/customers/unsubscribe' => 'customers#unsubscribe' #顧客の退会確認画面
    patch '/customers/withdraw' => 'customers#withdraw' #顧客の退会処理(ステータスの更新)

    resources :cart_items ,only:[:index, :update, :create, :destroy]
    delete '/cart_items/destroy_all' => 'cart_items#destroy_all'

    resources :orders ,only:[:new, :index, :show, :create]
    post '/orders/confirm' => 'orders#confirm' #注文情報確認画面
    get '/orders/complete' => 'orders#complete' #注文完了画面

    resources :addresses ,only:[:index, :edit, :create, :update, :destroy] #配送先情報など

  end

end
