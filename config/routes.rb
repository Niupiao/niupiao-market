Rails.application.routes.draw do
  
  # TODO: Need to set up "home page" routes for both English and 
  #    Mongolian versions.
  
  root 'static_pages#home'

  get 'about' => 'static_pages#about'
  
  get 'login' => 'sessions#new'
  
  post 'login' => 'sessions#create'
  
  get 'logout' => 'sessions#destroy'
  
  scope "(/:locale)", locale: /en|mn/ do
    resources :items
    resources :users
  end
end
