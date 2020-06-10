Rails.application.routes.draw do
  
  root to: "pages#home"

  resources :registrations, only: [:create]
  
end
