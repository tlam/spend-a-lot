SpendALot::Application.routes.draw do

  resources :trends do
    collection do
      match ':slug' => 'trends#category', :as => :category, via: [:get]
      #match 'photos', to: 'photos#show', via: [:get, :post]
      match 'trends/:slug/:year/:month' => 'trends#monthly', :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}, :as => :category_monthly, via: [:get]
    end
  end

  resources :categories do
    collection do
      post 'assign'
      match 'ajax-by-keyword' => 'categories#ajax_by_keyword', via: [:get]
    end
  end

  resources :expenses do
    collection do
      get 'descriptions'
      get 'download'
      match ':year/:month' => 'expenses#monthly', :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}, :as => :monthly, via: [:get]
    end
  end

  resources :keywords

  resources :statements do
    collection do
      get 'delete'
      post 'csv'
      post 'load'
      post 'upload'
      post 'wesabe'
    end
  end

  root :to => 'home#index', :as => :home

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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
