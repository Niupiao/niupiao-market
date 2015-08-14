Rails.application.routes.draw do

  # TODO: Need to set up "home page" routes for both English and 
  #    Mongolian versions.
  
  root 'static_pages#home'
  
  # SuperAdmin routes
  get 'crunch' => 'super_admins#crunch'  # Fairly dangerous data crunching at its finest.
  post 'admin/driver/update' => 'super_admins#update_driver'
  post 'admin/driver/invoice' => 'super_admins#pay_driver'
  get 'admin' => 'super_admins#admin'
  post 'admin' => 'sessions#admin'
  get 'admin/status' => 'super_admins#update_status'
  post 'admin/update' => 'super_admins#update_receipt'

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
  
  get 'driver/create' => 'drivers#create'
  get 'driver/edit' => 'drivers#edit'
  get 'driver/owed' => 'drivers#update_owed'
  get 'driver/delete' => 'drivers#delete'
  
  post 'items_review' => 'items#review'
  post 'users_review' => 'users#review'
  
  get 'auth/:provider/callback' => 'sessions#create'
  get 'auth/failure' => '/'
  get 'signout' => 'sessions#destroy'
  
  # mobile routes
  get 'mobile/register' => 'mobile#register'
  get 'mobile/login' => 'mobile#login'
  get 'mobile/items' => 'mobile#items'
  get 'mobile/item' => 'mobile#item'
  get 'mobile/user' => 'mobile#user'
  
  # Update routes
  get 'mobile/updatefacebookid' => 'mobile#update_facebook_id'
  get 'mobile/updateuser' => 'mobile#update_user'
  get 'mobile/updatephone' => 'mobile#update_phone'
  get 'mobile/renewtoken' => 'mobile#renew_token'
  
  # Email routes
  get 'mobile/isemailconfirmed' => 'mobile#email_confirmed?'
  get 'mobile/confirmemail' => 'mobile#email_confirm'
  
  # payment methods
  get 'mobile/addpayment' => 'mobile#add_payment_method'
  get 'mobile/updatepayment' => 'mobile#update_payment_method'
  get 'mobile/getpaymentmethods' => 'mobile#get_payment_methods'
  get 'mobile/deletepayment' => 'mobile#remove_payment_method'
  
  get 'mobile/selfreviews' => 'mobile#self_reviews'
  get 'mobile/updateaddress' => 'mobile#update_address'
  get 'mobile/receipts' => 'mobile#receipts'
  get 'mobile/salereceipts' => 'mobile#sale_receipts'
  get 'mobile/purchasereceipts' => 'mobile#purchase_receipts'
end
