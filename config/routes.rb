Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  get '/items/my', to: 'items#my'
  resources :items do
    resources :books
    resources :reviews
  end
  resources :users do
    resources :reviews
  end
  resources :cities , :categories
  root to: 'items#index'
end
