Rails.application.routes.draw do
<<<<<<< HEAD
  
  root 'items#new'
 
=======
>>>>>>> 0a0ec278122b64d41007af48b4b0312611cce16f
  resources :items
  
  root 'items#index'
end
