require 'resque/server'

Rails.application.routes.draw do
  mount Resque::Server.new, at: "/resque"
  scope "(:locale)" do
    root 'welcome#index'
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)
    resources :categories do
      resources :images do
        post 'new_like', on: :member
        delete 'delete_like', on: :member
        resources :comments
      end
      put 'new_folower', on: :member
      put 'delete_folower', on: :member
    end
    get 'images/index'
    get 'welcome/index'
    devise_for :users, skip: :omniauth_callbacks, controllers: { registrations: 'users/registrations', passwords: 'users/passwords', omniauth_callbacks: 'omniauth_callbacks' }
  end
  devise_for :users, only: :omniauth_callbacks, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
end
