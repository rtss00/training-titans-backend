Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  mount ActionCable.server => '/cable'

  namespace :api do
    resources :conversations, only: [:index, :show, :create]
    resources :profiles, only: [:index, :show, :create]
    resources :technologies, only: [:index, :show]
    resources :languages, only: [:index, :show]
  end
end
