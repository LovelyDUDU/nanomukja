Rails.application.routes.draw do
  devise_for :users, controllers: {
           :sessions => "users/sessions",
           :registrations => "users/registrations" }
           
  root 'main#get_location'
  
  get '/map_page' => 'main#map_page'
  get '/first' => 'main#first'
  post '/first' => 'main#first'
  get '/second' => 'main#second'
  get '/write' =>'main#write'
  get '/read/:post_id' => 'main#read'
  get '/test' => 'main#test'
  get '/profile/:user_id'=>'main#profile'
  get '/maptest' => 'main#maptest'
  post '/write_ok' => 'main#write_ok'
  post '/position_ok' => 'main#position_ok'
  post '/comment_reg' =>'main#comment_reg'
  get '/get_location' => 'main#get_location'
  get '/follow_request/:user_id' => 'main#follow_request' 
  get '/follow_cancel/:user_id' => 'main#follow_cancel'
  
  post '/post_delete' => 'main#post_delete'
  post '/post_update' => 'main#post_update'
  post '/post_update_ok' => 'main#post_update_ok'
  
  post '/back_photo_reg' => 'main#back_photo_reg'
  post '/profile_photo_reg' => 'main#profile_photo_reg'
  post '/profile_introduce_reg' => 'main#profile_introduce_reg'
  post '/read_message' => 'main#read_message'
  post '/send_message' => 'main#send_message'
  post '/send_message_ok' => 'main#send_message_ok'
  
  
  
  
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
