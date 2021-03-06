Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  get '/items/my', to: 'items#my'
  get '/items/all', to: 'items#index_all'
  resources :books, only: [:update,:show]
  resources :items, only: [:create,:update,:destroy,:show,:index] do
    resources :books, only: [:create,:update,:destroy,:show,:index]
    resources :reviews, only: [:create,:update,:destroy,:show,:index]
  end
  resources :users do
    resources :reviews, only: [:create,:update,:destroy,:show,:index]
    resources :books, only: [:index]
  end
  resources :cities, only: [:create,:update,:destroy,:show,:index]
  resources :categories, only: [:create,:update,:destroy,:show,:index]
  resources :users, only: [:create,:update,:destroy,:show,:index]
  resources :home, only: [:create,:update,:destroy,:show,:index]
  root to: 'items#index'



  # Home controller routes.
  root   'home#index'
  get    'auth'            => 'home#auth'

  # Get login token from Knock
  post   'user_token'      => 'user_token#create'

  # User actions
  get    '/users'          => 'users#index'
  get    '/users/current'  => 'users#current'
  post   '/users/create'   => 'users#create'
  patch  '/user/:id'       => 'users#update'
  delete '/user/:id'       => 'users#destroy'

end
