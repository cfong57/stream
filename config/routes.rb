Stream::Application.routes.draw do

  #borrowing route structure as a reminder for how this works

  #these should still be applicable though
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }
  match "about" => 'welcome#about', via: :get
  root :to => 'welcome#index'




  resources :users, only: [:show, :index]
  
  resources :posts, only: [:index]
  resources :topics do
    resources :posts, except: [:index], controller: 'topics/posts' do
      resources :comments
      match '/up-vote', to: 'votes#up_vote', as: :up_vote
      match '/down-vote', to: 'votes#down_vote', as: :down_vote
      resources :favorites, only: [:create, :destroy]
    end
  end
end