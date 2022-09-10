Rails.application.routes.draw do
    scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about' ,as: 'about'
    resources :items ,only:[:index, :show]
   

  end
# 顧客用
# URL /customers/sign_in ...
  devise_for :customers,skip:[:passwords],controllers:{
    registration: "public/registrations",
    sessions: 'public/sessions'
  }

# 管理者用
# URL /admin/sign_in ...
  devise_for :admin,skip:[:registrations,:passwords],controllers:{
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
