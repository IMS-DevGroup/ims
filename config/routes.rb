Rails.application.routes.draw do

  get 'impressum/index'

  resources :boss_configs
  resources :notifications
  resources :device_groups
  
  get 'set_language/english'
  get 'set_language/german'

  root  'sessions#new'
  get   'login'   =>  'sessions#new'
  post  'login'   =>  'sessions#create'
  get   'logout'  =>  'sessions#remove'
  post  'get-prop'=>  'devices#get_properties'
  get   'lendings/:id/return' => 'lendings#return', as: 'return_lending'
  get   'operations/show_lendings' => 'operations#show_lendings', as: 'show_lendings'
  # route for first try of multiple-device-lending
  # post  'delete_from_list' => 'lendings#delete_from_list'
  resources :starts
  resources :todos
  resources :operations
  resources :units
  resources :stocks
  resources :device_types
  resources :data_types
  resources :properties
  resources :values
  resources :devices
  resources :lendings
  resources :sessions
  resources :users
  resources :rights
  resources :barcodes
  resources :lendings_selector
  resources :contacts, only: [:new, :create]
  resources :impressum

  match '/contacts', to: 'contacts#new', via: 'get'
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :notifications
  resources :device_groups
  resources :boss_configs

  get '/new', to: redirect('/starts')   #TODO
  get '/*other', to: redirect('/starts')



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
