Rails.application.routes.draw do
  
  # Need to set up routes to both English and Mongolian 
  root 'static_pages#home'

  get 'about' => 'static_pages#about'

  get 'items' => 'static_pages#items'
  
  get 'items/new'
  
  scope "(/:locale)", locale: /en|mn/ do
    resources :items
    resources :users
  end
  
end
