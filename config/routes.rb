Rails.application.routes.draw do
  get 'items/new'
  get 'items/create'
  get 'items/update'
  get 'items/edit'
  get 'items/destroy'
  get 'items/index'
  get 'items/show'
  get 'reviews/new'
  get 'reviews/create'
  get 'reviews/update'
  get 'reviews/edit'
  get 'reviews/destroy'
  get 'reviews/index'
  get 'reviews/show'
  get 'books/new'
  get 'books/create'
  get 'books/update'
  get 'books/edit'
  get 'books/destroy'
  get 'books/index'
  get 'books/show'
  post 'user_token' => 'user_token#create'
  get '/items/my', to: 'items#my'
  resources :items do
    resources :books
    resources :reviews
  end
  resources :users do
    resources :reviews
  end
  root to: 'items#index'
end
