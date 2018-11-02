Rails.application.routes.draw do
  root 'welcome#index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :categories do
    resources :images do
      resources :comments
    end
    put 'new_folower', on: :member
    put 'delete_folower', on: :member
  end
  get 'images/index'
  get 'welcome/index'
  devise_for :users
  resources :users
  resource :likes


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
