Rails.application.routes.draw do
  
  
  
  root 'items#new'
 
  resources :items
end
