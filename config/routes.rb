Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  get '/items/my', to: 'items#my'
  resources :items, only: [:create,:update,:destroy,:show,:index] do
    resources :books
    resources :reviews
  end
  resources :users do
    resources :reviews
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
