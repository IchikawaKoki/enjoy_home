Rails.application.routes.draw do

  root to: 'homes#top'
  get 'homes/about'

  devise_for :users
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  resources :users, only: [:show, :edit, :update, :destroy] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  resources :posts do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  resources :rooms, only: [:create, :index, :show]

  get 'search' => 'searches#search', as: "search"
  get 'tags/:id' => 'tags#search', as: "tag_search"
end
