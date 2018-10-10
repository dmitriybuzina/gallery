Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :categories
  get 'welcome/index'
  resources :images
  root 'welcome#index'
  devise_for :users
  resources :users
  resources :comments

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
