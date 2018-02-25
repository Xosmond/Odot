Rails.application.routes.draw do
  devise_for :users
  get 'perfil/:id', to: "users#show", as: :perfil

  devise_scope :user do
   get "login" , to: "devise/sessions#new", as: :login
   get "logout" , to: "devise/sessions#destroy", as: :logout
   get "registro" , to: "devise/registrations#new", as: :registro
  end
  resources :todo_lists do
    resources :todo_items do
      patch :complete
    end
  end
  root 'pages#home'
end
