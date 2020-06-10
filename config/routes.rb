Rails.application.routes.draw do
  
  root to: "pages#home"

  resources :registrations, only: [:create]
  
  resources :registration_tokens, only: [:create]

end
