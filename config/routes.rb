Rails.application.routes.draw do
  
  use_doorkeeper
  
  root to: "pages#home"

  resources :registrations, only: [:create]
  
  resources :registration_tokens, only: [:create]

  resources :login_checks, only: [:create]

  resources :quill_blog_posts, only: [:index, :show, :create, :update, :destroy]
end
