Rails.application.routes.draw do
  
  # TODO: Need to set up "home page" routes for both English and 
  #    Mongolian versions.
  
  root 'static_pages#home'

  get 'about' => 'static_pages#about'
  
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'
  get 'cart' => 'sessions#show_cart'
  post 'cart' => 'sessions#add_to_cart'
  post 'delete_from_cart' => 'sessions#remove_from_cart'
  get 'checkout' => 'sessions#checkout'
  
  scope "(/:locale)", locale: /en|mn/ do
    resources :items
    resources :users
  end
end
