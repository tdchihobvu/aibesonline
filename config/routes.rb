Blog::Application.routes.draw do

  resources :users

  get "manage/index"

  resources :products do
      collection do
      post :search_ajax
      post :save_uploaded_image
      get :upload_image
      get :products_by_category
      get :category_products
      end
  end

  resources :product_types

  resources :posts
  
  resources :store do
    collection do
      post :add_to_cart
      post :empty_cart
      post :checkout
      post :save_order
      post :save_request
      post :save_comment
      post :search_ajax
      post :login
      post :activate
      post :activate_renewal
      post :create_new_user
      post :update_user_account
      get :sign_in
      get :category_items
      get :products_by_alphabet
      get :testajax
      get :latest
      get :customer_requests
      get :comments
      get :products_atoz
      get :checkout
      get :activate_account
      get :renew_account
      get :new_user
      get :terms_conditions
      get :getting_started
      get :edit_user_account
      get :logout
      get :on_promotion
      
    end
  end

  resources :manage do
    collection do
      post :process_payment
      post :login
      post :save_slideshow_image
      post :update_settings
      get :update_slide_image
      get :delete_slide_image
      get :logout
      get :reports
      get :sign_in
      get :unpaid_orders
      get :unprocessed_orders
      get :undelivered_orders
      get :uncollected_orders
      get :slideshow
    end
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
    root :to => "store#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'

    match "/*other" => "store#index"
end
