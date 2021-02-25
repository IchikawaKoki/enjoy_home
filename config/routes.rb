Rails.application.routes.draw do

  root to: 'homes#top'

  devise_for :users, skip: :all
  devise_scope :user do
    post '/users/guest_sign_in' => 'users/sessions#new_guest'
    get '/users/sign_up' => 'users/registrations#new', as: :new_user_registration
    post '/users' => 'users/registrations#create', as: :user_registration
    get '/users/sign_in' => 'users/sessions#new', as: :new_user_session
    post '/users/sign_in' => 'users/sessions#create', as: :user_session
    get '/users/edit' => 'users/registrations#edit', as: :edit_user_registration
    patch '/users/update' => 'users/registrations#update', as: :update_user_registration
    delete '/users/sign_out' => 'users/sessions#destroy', as: :destroy_user_session
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

  resources :notifications, only: [:index]

  get 'search' => 'searches#search', as: "search"
  get 'tags/:id' => 'tags#search', as: "tag_search"

  get 'inquiries/new' => 'inquiries#new'
  get 'inquiries/confirm' => 'inquiries#confirm'
  get 'inquiries/thanks' => 'inquiries#thanks'
end
