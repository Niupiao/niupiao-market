Rails.application.routes.draw do

  # TODO: Need to set up "home page" routes for both English and 
  #    Mongolian versions.
  
  root 'static_pages#home'

  get 'about' => 'static_pages#about'
  get 'items' => 'items#show'
  get 'search' => 'items#search'
  
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'
  delete 'logout' => 'sessions#destroy'
  get 'cart' => 'sessions#show_cart'
  post 'cart' => 'sessions#add_to_cart'
  post 'delete_from_cart' => 'sessions#remove_from_cart'
  post 'update_cart' => 'sessions#update_cart'
  get 'purchase' => 'sessions#purchase_cart'
  get 'checkout' => 'sessions#checkout'
  get 'remove_item' => 'items#destroy'
  get 'delete_user' => 'users#destroy'
  scope "(/:locale)", locale: /en|mn/ do
    resources :items
    resources :users
  end
  post 'review' => 'items#comment'
end
