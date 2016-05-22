Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'training#index'

  resources :training

  resources :exercise_sets do
    resources :exercises
  end

  resources :user

  # TODO : already provided by resources
  post '/exercise_sets/:id/add_exercise/', to: 'exercise_sets#add_exercise'

  get '/sign_in', to: 'session#new', as: 'sign_in'
  post '/sign_in', to: 'session#create'
  get '/logout', to: 'session#destroy', as: 'logout'

  delete '/exercises/:id', to: 'exercises#destroy', as: 'delete_exercise'
  get '/exercises', to: 'exercises#index'

  post '/trainings/exercises/:id', to: 'training#add_exercise', as: 'add_exercise_to_training'
  post '/trainings/exercise_sets/:id', to: 'training#add_exercise_set', as: 'add_exercise_set_to_training'
  post '/training/failed/:id', to: 'training#failed', as: 'failed_training'
  post '/training/done/:id', to: 'training#done', as: 'done_training'
  get '/debug', to: 'training#debug'


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
