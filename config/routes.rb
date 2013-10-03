Bookstore::Application.routes.draw do

  
  resources :category_items


  resources :books

  resources :categories
  controller :categories do
    get 'category/up/:id' => 'categories#up', as: 'category_up'
    get 'category/down/:id' => 'categories#down', as: 'category_down'
    get 'category/book_display/:id' => 'categories#book_display', as: 'category_book_display' 
    get 'category/book_add/:category_id/:book_id' => 'categories#book_add', as: 'category_book_add' 
    get 'category/book_remove/:category_id/:book_id' => 'categories#book_remove', as: 'category_book_remove'
  end


  controller :session do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  resources :users

  controller :users do
    get 'activate/:token' => 'users#activate', as: 'activate'
    get 'user/upgrade/:id' => 'users#upgrade', as: 'upgrade'
    get 'user/downgrade/:id' => 'users#downgrade', as: 'downgrade'
    get 'user/passwordreset' => 'users#password_reset', as: 'password_reset'
    post 'user/passwordreset' => 'users#password_reset', as: 'password_reset'
    get 'user/passwordresetresult/:token' => 'users#password_reset_result', as: 'reset_result'
    post 'user/passwordresetresult' => 'users#password_reset_result', as: 'password_reset_result'
  end
  
  controller :store do
    get 'store/index' => 'store#index', as: 'store'
    get 'store/index/:category' => 'store#index', as: 'store_browse'    
    post 'store/search' => 'store#book_search', as: 'book_search'    
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
  root to: 'store#index', as: 'store'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
