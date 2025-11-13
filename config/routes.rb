Rails.application.routes.draw do
  get "search_histories/destroy"
  get "users/show"
  get "users/edit"
  get "users/update"
  devise_for :users
  get 'hello/index' => 'hello#index'
  

  get 'hello/link' => 'hello#link'

  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  

  # Defines the root path route ("/")
  # root "posts#index"

 

  # :editと:updateを追加

  devise_scope :user do
  post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end


  
  
resources :search_histories, only: [:destroy]
 resource :user, only: [:show, :edit, :update]  # マイページは1ユーザー1ページなので単数形でOK

  resources :tweets do
  
    collection do
     get :search
     get :my_posts  # /tweets/my_posts にアクセスできる
    end
    resource :likes, only: [:create, :destroy]
 end

  

  root "tweets#index"

  
  
end
