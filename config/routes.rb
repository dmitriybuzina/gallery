Rails.application.routes.draw do
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
    devise_for :users, skip: :omniauth_callbacks, controllers: { registrations: 'users/registrations', passwords: 'passwords', omniauth_callbacks: 'omniauth_callbacks' }

      # devise_for :users
         # resource :users
  end
  # devise_for :users, controllers: { registrations: 'users/registrations', passwords: 'passwords', omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_for :users, only: :omniauth_callbacks, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
