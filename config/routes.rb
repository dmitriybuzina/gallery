Rails.application.routes.draw do
  resources :categories
  get 'welcome/index'
  resources :images
  root 'welcome#index'
  devise_for :users
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
