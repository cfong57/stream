Stream::Application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }
  match "about" => 'welcome#about', via: :get
  match "public" => 'welcome#public', via: :get
  root :to => 'welcome#index'

  resources :users
  resources :songs
  resources :tags
end