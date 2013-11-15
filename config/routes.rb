
Workflow::Application.routes.draw do
  #devise_for :users


  devise_for :users do get '/users/sign_out' => 'devise/sessions#destroy' end
  
  
  
  match '/users/sign_in' => redirect('/')  
    
  get "workflow_item/allworkflowitems"
  
  post "workflow_item/load"
  post "workflow_item/newWorkflowitemAdded"
  
  get "workflow_item/show"
  
  post "workflow_item/formsubmit"
  post "workflow_item/clearSession"
  
  post "workflow_item/runTheJobsNow"
  post "workflow_item/newConnectionAdded"
  
  post "workflow_item/getJobStatuses"
  
  post "workflow_item/getJobOutput"
  post "workflow_item/startnewjob"
  
  post "workflow_item/savethejob"
  post "workflow_item/gethtmlforwidget"
  
  
  get "listalljobs/alljobs"
  get "listalljobs/get_all_jobs"
  
  get "/listalljobs/loadjobdetails"
  
  post "workflow_item/createShellCommands"
  
  post "/workflow_item/test_data_recieved"
  
  post "/workflow_item/saveUiCoordinates"
  
  post "/workflow_item/restorejob"
  
  post "/workflow_item/getJobsToRestore"
  
  post "/workflow_item/retrieve_notifications"
  
  post "/workflow_item/removeWorkflowitem"
  
  post "/workflow_item/create_form_for_job_name"
  
  get "/add_workflowitem/create_new_workflowitem"
  
  get "/add_workflowitem/create"
  
  post "add_workflowitem/create_new_workflowitem_formsubmit"
  
  post "add_workflowitem/delete"
  
  #match "/delayed_job" => DelayedJobWeb, :anchor => false
  
  #get "workflow_item/newWorkflowitemAdded"

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
   root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
