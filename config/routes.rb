Rails.application.routes.draw do
  
  use_doorkeeper
  
  root to: "pages#home"

  resources :registrations, only: [:create]
  
  resources :registration_tokens, only: [:create]

end
