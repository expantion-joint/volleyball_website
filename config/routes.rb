Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # devise
  devise_for :users, controllers: {
    registrations: 'users/registrations', # edit_user_registration_path
  }

  # post
  get '/', to: 'posts#top', as: 'top_post'
  get 'posts/index', to: 'posts#index', as: 'index_post'
  get 'posts/new', to: 'posts#new', as: 'new_post'
  post 'posts/new', to: 'posts#create', as: 'create_post'
  get 'posts/show/:id', to: 'posts#show', as: 'show_post' # post.id
  get 'posts/edit/:id', to: 'posts#edit', as: 'edit_post' # post.id
  post 'posts/edit/:id', to: 'posts#update', as: 'update_post' # post.id
  delete 'posts/destroy/:id', to: 'posts#destroy', as: 'destroy_post' # post.id

  # order
  get 'orders/index', to: 'orders#index', as: 'index_order'
  post 'orders/new/:id', to: 'orders#create', as: 'create_order' # post.id
  get 'orders/show/:id', to: 'orders#show', as: 'show_order' # post.id
  post 'orders/edit/:id', to: 'orders#update', as: 'update_order' # post.id

  # contributor
  get 'contributors/index', to: 'contributors#index', as: 'index_contributor'
  get 'contributors/new', to: 'contributors#new', as: 'new_contributor'
  post 'contributors/new', to: 'contributors#create', as: 'create_contributor'
  get 'contributors/show/:id', to: 'contributors#show', as: 'show_contributor' # post.id
  get 'contributors/edit', to: 'contributors#edit', as: 'edit_contributor'
  post 'contributors/edit', to: 'contributors#update', as: 'update_contributor'
  delete 'contributors/destroy/:id', to: 'contributors#destroy', as: 'destroy_contributor' # contributor.id

  # admin
  get 'admins/edit_all_user', to: 'admins#edit_all_user', as: 'edit_all_user_admin' # post.id
  post 'admins/edit_all_user/:id', to: 'admins#update_all_user', as: 'update_all_user_admin' # post.id

end
