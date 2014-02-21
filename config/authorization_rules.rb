authorization do
  role :registered do
    has_permission_on [:store], :to => [
      :sign_in,
      :login,
      :logout,
      :search_ajax,
      :index,
      :testajax,
      :products_atoz,
      :products_by_alphabet,
      :add_to_cart,
      :empty_cart,
      :save_order,
      :customer_requests,
      :save_requests,
      :comments,
      :save_comment,
      :category_items,
      :activate_account,
      :activate,
      :renew_account,
      :activate_renewal,
      :new_user,
      :create_new_user,
      :terms_conditions,
      :getting_started,
      :edit_user_account,
      :update_user_account
    ]

    has_permission_on [:manage], :to => [
      :sign_in,
      :login,
      :logout
    ]

    has_permission_on [:users], :to => [
      :edit,
      :update
    ]
  end

  role :manager do
    has_permission_on [:store], :to => [
      :sign_in,
      :login,
      :search_ajax,
      :index,
      :testajax,
      :products_atoz,
      :products_by_alphabet,
      :add_to_cart,
      :empty_cart,
      :save_order,
      :customer_requests,
      :save_requests,
      :comments,
      :save_comment,
      :category_items,
      :activate_account,
      :activate,
      :renew_account,
      :activate_renewal,
      :new_user,
      :create_new_user,
      :terms_conditions,
      :getting_started,
      :edit_user_account,
      :update_user_account
    ]

    has_permission_on [:manage], :to => [
      :sign_in,
      :login,
      :logout,
      :index,
      :unpaid_orders,
      :unprocessed_orders,
      :undelivered_orders,
      :uncollected_orders,
      :process_payment,
      :update_payment,
      :order_processing_by_admin,
      :update_order,
      :reports,
      :slideshow,
      :save_slideshow_image,
      :update_settings,
      :update_slide_image,
      :delete_slide_image
    ]

    has_permission_on [:products], :to => [
      :index,
      :search_ajax,
      :show,
      :new,
      :edit,
      :create,
      :update,
      :upload_image,
      :save_uploaded_image,
      :destroy,
      :products_by_category,
      :category_products
    ]

    has_permission_on [:product_types, :users], :to => [
      :new,
      :create,
      :index,
      :show,
      :edit,
      :update
    ]
  end
end