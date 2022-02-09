Rails.application.routes.draw do
  devise_for :users, path: 'users'
  devise_for :admins, path: 'admins'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      devise_for 'User', at: 'auth', skip: [:omniauth_callbacks]
      post 'social_auth/callback', to: 'social_auth_controller#authenticate_social_auth_user' # this is the line where we add our routes
      resources :users
      resources :admins
    end
  end
end
