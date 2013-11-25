Stream::Application.routes.draw do
  devise_for :users, :path_prefix => 'my', controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }
  resources :users, :controller => "users"
  root :to => 'welcome#index'

  match "about" => 'welcome#about', via: :get
  match "anonymous" => 'welcome#anonymous', via: :get
  match "business" => 'welcome#business', via: :get

  resources :songs
  resources :tags
end