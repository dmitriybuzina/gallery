Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :categories do
    put 'new_folower', on: :member
    put 'delete_folower', on: :member
  end
  get 'welcome/index'
  get 'profiles/index'
  resources :images do
    resources :comments
    put 'new_like', on: :member
    put 'delete_like', on: :member
  end
  resources :profiles
  root 'welcome#index'
  devise_for :users
  resources :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
