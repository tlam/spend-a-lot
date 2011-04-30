SpendALot::Application.routes.draw do
  match 'trends' => 'Trends#index'
  match 'trends/:slug' => 'Trends#category', :as => :trends_category
  match 'trends/:slug/:year/:month' => 'Trends#monthly', :as => :trends_category_monthly

  resources :categories do
    collection do
      get 'assign'
    end
  end
  resources :expenses do
    collection do
      get 'descriptions'
    end
  end
  resources :keywords

  get 'home/index'
  root :to => 'Home#index', :as => :home

  match 'categories/assign' => 'categories#assign'
  match 'statements' => 'Statements#index'
  match 'statements/delete' => 'Statements#delete'
  match 'statements/load' => 'Statements#load'
  match 'statements/upload' => 'Statements#upload'
  match 'statements/wesabe' => 'Statements#wesabe'

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
