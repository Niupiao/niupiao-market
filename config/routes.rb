Rails.application.routes.draw do
  root 'static_pages#home'

  get 'about' => 'static_pages#about'

  get 'items' => 'static_pages#items'
  
  get 'items/new'
  
  resources :items
  
end
