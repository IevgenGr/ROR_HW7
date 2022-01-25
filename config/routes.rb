Rails.application.routes.draw do
  root 'posts#index'
  get 'signup', to: 'authors#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'search', to: 'posts#search', as: 'search'

  resources :sessions
  resources :authors
  resources :posts do
    resources :comments do
      member do
        get 'publish_comment'
      end
    end
  end
end
