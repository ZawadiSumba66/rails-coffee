Rails.application.routes.draw do
  devise_for :users, path: 'users'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      post :auth, to: 'authentication#create'
      post '/presigned_url', to: 'direct_upload#create'
      devise_for 'User', at: 'auth', skip: [:omniauth_callbacks]
      post 'social_auth/callback', to: 'social_auth_controller#authenticate_social_auth_user' # this is the line where we add our routes
      resources :users
      resources :avatars
      resources :coffees
      resources :espressos, only: %i[index show]
      resources :lattes, only: %i[index show]
      resources :populars, only: %i[index show]
      scope '/admin' do
        resources :espressos, only: :create
        resources :lattes, only: :create
        resources :populars, only: :create
      end
    end
  end
end
