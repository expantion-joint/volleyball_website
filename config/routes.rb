Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get '/', to: 'posts#top', as: 'top_post'
  get 'posts/index', to: 'posts#index', as: 'index_post'
  get 'posts/new', to: 'posts#new', as: 'new_post'
  post 'posts/new', to: 'posts#create', as: 'create_post'
  get 'posts/show/:id', to: 'posts#show', as: 'show_post' # post.id
  get 'posts/edit/:id', to: 'posts#edit', as: 'edit_post' # post.id
  post 'posts/edit/:id', to: 'posts#update', as: 'update_post' # post.id
  delete 'posts/destroy/:id', to: 'posts#destroy', as: 'destroy_post' # post.id

end
