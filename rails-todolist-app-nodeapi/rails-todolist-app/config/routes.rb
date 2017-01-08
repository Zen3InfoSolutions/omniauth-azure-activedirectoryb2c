Rails.application.routes.draw do


  root 'home#index'
  get 'home/profile'
  get 'auth/:provider/callback', to: "sessions#create"
  post 'auth/:provider/callback', to: "sessions#create"
  get 'tasks/show', to: "tasks#show"
  post 'tasks/create', to: "tasks#create"
  delete 'sign_out', to: "sessions#destroy", as: 'sign_out'
end
