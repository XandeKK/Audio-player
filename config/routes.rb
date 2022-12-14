Rails.application.routes.draw do
  root 'home#index'

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "sessions", only: [:create]

  resources :users, controller: "users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:edit, :update]
  end

  get "/sign_in" => "sessions#new", as: "sign_in"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"

  resources :musics, except: [:index, :show]

  resources :profile, except: [:index, :new, :create, :destroy]
  delete "/delete/profile", to: "profile#destroy", as: "delete_profile"

  post "search", to: "search#index"#, format: :turbo_stream
end
