Rails.application.routes.draw do
  get 'users/new'

  get 'users/show'

  get 'users' => 'users#index'

  root 'static_pages#home'

  get 'about' => 'static_pages#about'

  get 'items' => 'static_pages#items'
  
  get 'items/new'
  
  resources :items
  resources :users
end
