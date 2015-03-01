Rails.application.routes.draw do

  root 'main#index', :as => "index"
  post 'login' => 'main#login', :as => "login"
  get 'dashboard' => 'main#dashboard', :as => "dashboard"

  get 'blink' => "main#blink", :as => "blink"
  get 'blink/:lat/:long' => "main#blinkex", :as => "blinkex"
  get 'logout' => "main#logout", :as => "logout"

  post 'explore' => "main#explore", :as => "explore"
  get 'explore' => "main#explore", :as => "explore_get"
  get 'pindex' => "main#pindex", :as => "pindex"
  post 'plan_pintrip' => "main#plan_pintrip", :as => "plan_pintrip"
  get 'pintrip' => "main#pintrip", :as => "pintrip"
  get 'pinmap' => "main#pinmap", :as => "pinmap"
  post 'finalize_trip' => "main#finalize_trip", :as => "finalize_trip"

  get 'recording' => "main#recording", :as => "recording"


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
