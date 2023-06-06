Rails.application.routes.draw do
  get 'relationships/followings'
  get 'relationships/followers'
  root to: "homes#top"
  get "home/about"=>"homes#about"
  devise_for :users
  
  resources :users,only: [:show,:index,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
end
