Rails.application.routes.draw do
  resources :events, only: [:index, :show, :create, :destroy, :update]
  get 'events/close/:id' => 'events#close'
  get 'events/next' => 'events#next'
  get 'choices/list/:id' => 'choices#list'
  get 'choices/show/:id' => 'choices#show'
  delete 'choices/:id/delete' => 'choices#delete'
  get 'choices/:id/is_correct' => 'choices#is_correct'
  post 'payments' => 'payments#purchase'
  get 'answerers/get_question' => 'answerers#get_question'

  resources :questions, only: [:index, :show, :create, :delete, :update]
  resources :answerers, only: [:update, :create, :show]

  resources :answers, only: [:index, :show, :update, :create]

  devise_for :admin_users, controllers: { sessions: "session",
   registrations: "registration", confirmations: "confirmation",
   passwords: "password" }
  get 'admin/index'
  get 'admin/show'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  root to: "admin#index"

  # You can have the root of your site routed with "root"

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  resource :authentication_token, only: [:update, :destroy]

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
