Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # devise
  devise_for :users, controllers: {
    registrations: 'users/registrations', # edit_user_registration_path
    sessions:      'users/sessions',
    passwords:     'users/passwords'
  }

  # post
  get '/', to: 'posts#index', as: 'index_post'
  get 'posts/new', to: 'posts#new', as: 'new_post'
  post 'posts/new', to: 'posts#create', as: 'create_post'
  get 'posts/show/:id', to: 'posts#show', as: 'show_post' # post.id
  get 'posts/edit/:id', to: 'posts#edit', as: 'edit_post' # post.id
  post 'posts/edit/:id', to: 'posts#update', as: 'update_post' # post.id
  delete 'posts/destroy/:id', to: 'posts#destroy', as: 'destroy_post' # post.id
  get 'posts/index_reservation_holder', to: 'posts#index_reservation_holder', as: 'index_post_reservation_holder'
  get 'posts/show_reservation_holder/:id', to: 'posts#show_reservation_holder', as: 'show_post_reservation_holder' # post.id
  get 'posts/show_terms_of_use', to: 'posts#show_terms_of_use', as: 'show_post_terms_of_use'
  post 'posts/back', to: 'posts#back', as: 'back_post'
  
  # order
  get 'orders/index', to: 'orders#index', as: 'index_order'
  post 'orders/new/:id', to: 'orders#create', as: 'create_order' # post.id
  get 'orders/show/:id', to: 'orders#show', as: 'show_order' # post.id
  post 'orders/edit/:id', to: 'orders#update', as: 'update_order' # post.id
  post 'posts/show_reservation_holder/:id', to: 'orders#update_reservation_holder', as: 'update_order_reservation_holder' # order.id

  # contributor
  get 'contributors/index', to: 'contributors#index', as: 'index_contributor'
  get 'contributors/new', to: 'contributors#new', as: 'new_contributor'
  post 'contributors/new', to: 'contributors#create', as: 'create_contributor'
  get 'contributors/show/:id', to: 'contributors#show', as: 'show_contributor' # post.id
  get 'contributors/edit', to: 'contributors#edit', as: 'edit_contributor'
  post 'contributors/edit', to: 'contributors#update', as: 'update_contributor'
  delete 'contributors/destroy/:id', to: 'contributors#destroy', as: 'destroy_contributor' # contributor.id

  # admin
  get 'admins/edit_all_user', to: 'admins#edit_all_user', as: 'edit_all_user_admin'
  post 'admins/edit_all_user/:id', to: 'admins#update_all_user', as: 'update_all_user_admin' # post.id
  get 'admins/input_password', to: 'admins#input_password', as: 'input_password_admin'
  post 'admins/input_password', to: 'admins#confirm_password', as: 'confirm_password_admin'
  delete 'admins/destroy/:id', to: 'admins#destroy', as: 'destroy_admin' # user.id
  
  # information
  get 'informations/index', to: 'informations#index', as: 'index_information'
  get 'informations/new', to: 'informations#new', as: 'new_information'
  post 'informations/new', to: 'informations#create', as: 'create_information'
  get 'informations/show/:id', to: 'informations#show', as: 'show_information' # information.id
  get 'informations/edit/:id', to: 'informations#edit', as: 'edit_information' # information.id
  post 'informations/edit/:id', to: 'informations#update', as: 'update_information' # information.id
  delete 'informations/destroy/:id', to: 'informations#destroy', as: 'destroy_information' # information.id

  # contact
  get 'contacts/index', to: 'contacts#index', as: 'index_contact'
  get 'contacts/new', to: 'contacts#new', as: 'new_contact'
  post 'contacts/new', to: 'contacts#create', as: 'create_contact'
  get 'contacts/edit/:id', to: 'contacts#edit', as: 'edit_contact' # contact.id
  post 'contacts/edit/:id', to: 'contacts#update', as: 'update_contact' # contact.id
  delete 'contacts/destroy/:id', to: 'contacts#destroy', as: 'destroy_contact' # contact.id

end
