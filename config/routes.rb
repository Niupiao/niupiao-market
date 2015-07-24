Rails.application.routes.draw do

  # TODO: Need to set up "home page" routes for both English and 
  #    Mongolian versions.
  
  root 'static_pages#home'

  get 'about' => 'static_pages#about'

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
  
  get 'tracker' => 'receipts#tracker'
  get 'track' => 'receipts#track'
  post 'track' => 'receipts#track'
  
  get 'delete_user' => 'users#destroy'
  get 'storefront' => 'users#storefront'
  get 'receipts' => 'receipts#receipts'
  scope "(/:locale)", locale: /en|mn/ do
    resources :items
    resources :users
  end

  get 'delivery/login' => 'deliveries#login'
  get 'delivery/index' => 'deliveries#index'
  get 'delivery/claim' => 'deliveries#claim'
  patch 'delivery/claim' => 'deliveries#claim'
  get 'delivery/status' => 'deliveries#update_status'
  patch 'delivery/status' => 'deliveries#update_status'
  get 'delivery/claimed' => 'deliveries#claimed_deliveries'
  
  post 'items_review' => 'items#review'
  post 'users_review' => 'users#review'
  
  get 'auth/:provider/callback' => 'sessions#create'
  get 'auth/failure' => '/'
  get 'signout' => 'sessions#destroy'
  
  # mobile routes
  get 'mregister' => 'mobile#register'
  get 'mlogin' => 'mobile#login'
  get 'mitems' => 'mobile#items'
  get 'mitem' => 'mobile#item'
  get 'muser' => 'mobile#user'
  get 'mupdateuser' => 'mobile#update_user'
  get 'misemailconfirmed' => 'mobile#email_confirmed?'
  
  #payment methods
  get 'maddpayment' => 'mobile#add_payment_method'
  get 'mupdatepayment' => 'mobile#update_payment_method'
  get 'mgetpaymentmethods' => 'mobile#get_payment_methods'
  get 'mdeletepayment' => 'mobile#remove_payment_method'
  
  get 'mselfreviews' => 'mobile#self_reviews'
  get 'mupdateaddress' => 'mobile#update_address'
  get 'mreceipts' => 'mobile#receipts'
  get 'msalereceipts' => 'mobile#sale_receipts'
  get 'mpurchasereceipts' => 'mobile#purchase_receipts'
end
