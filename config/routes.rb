Bookstore::Application.routes.draw do

  
  resources :comments


  resources :category_items


  resources :books

  resources :categories
  controller :categories do
    get 'category/up/:id' => 'categories#up', as: 'category_up'
    get 'category/down/:id' => 'categories#down', as: 'category_down'
    get 'category/display_books/:id' => 'categories#display_books', as: 'category_display_books' 
    get 'category/display_other_books/:id' => 'categories#display_other_books', as: 'category_display_other_books' 
    get 'category/add_book/:category_id/:book_id' => 'categories#add_book', as: 'category_add_book' 
    get 'category/remove_book/:category_id/:book_id' => 'categories#remove_book', as: 'category_remove_book'
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
    get 'user/password_reset' => 'users#password_reset', as: 'password_reset'
    post 'user/password_reset' => 'users#password_reset', as: 'password_reset'
    get 'user/password_reset_result/:token' => 'users#password_reset_result', as: 'reset_result'
    post 'user/password_reset_result' => 'users#password_reset_result', as: 'password_reset_result'
    get 'user/change_email' => 'users#change_email', as: 'change_email_address'
    post 'user/change_email' => 'users#change_email', as: 'change_email'
    get 'user/change_password' => 'users#change_password', as: 'change_password'
    post 'user/change_password' => 'users#change_password', as: 'change_password'
  end
  
  controller :store do
    get 'store/index' => 'store#index', as: 'store'
    get 'store/index/:category' => 'store#index', as: 'store_browse'    
    get 'store/index/:category/:pagination' => 'store#index', as: 'store_browse_pag'    
    get 'store/search' => 'store#book_search', as: 'book_search'    
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
