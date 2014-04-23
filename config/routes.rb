FreightTms::Application.routes.draw do
  devise_for :users

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'  

  resources :freights, :contacts, :shippers
  get '/index', to: redirect('/')
  root to: 'main#index'
  
  get 'contacts/reactivate/:id' => "contacts#reactivate", as: :reactivate

  get 'main/bid/:freight'    => "main#bid"   , as: :bid
  get 'main/accept/:freight' => "main#accept", as: :accept
  
  get 'first_steps/shipper_info'                 => "first_steps#shipper_info"           , as: :shipper_info
  post 'first_steps/shipper_info_filled'         => 'first_steps#shipper_info_filled'    , as: :shipper_info_filled
  get 'first_steps/pricing'                      => "first_steps#pricing"                , as: :pricing
  get 'first_steps/pricing_choosed/:plan'        => 'first_steps#pricing_choosed'        , as: :pricing_choosed
  get 'first_steps/first_contacts'               => "first_steps#first_contacts"         , as: :first_contacts
  post 'first_steps/contact_added'               => 'first_steps#contact_added'          , as: :contact_added
  get 'first_steps/contacts_confirmed/:contacts' => 'first_steps#contacts_confirmed'     , as: :contacts_confirmed
  get 'first_steps/first_freight'                => "first_steps#first_freight"          , as: :first_freight
  post 'first_steps/first_freight_generated'     => 'first_steps#first_freight_generated', as: :first_freight_generated

  get 'first_steps/user_shipper'                 => "first_steps#user_shipper"           , as: :user_shipper

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
