Rails.application.routes.draw do
  root 'home#index'

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
end
