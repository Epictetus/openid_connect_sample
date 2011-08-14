OpenidConnectSample::Application.routes.draw do
  resource :session,   only: :destroy
  resource :dashboard, only: :show

  resources :clients,        only: [:new, :create, :destroy]
  resources :authorizations, only: [:new, :create]
  resources :access_tokens,  only: :create

  resource :id_token,  only: :show
  resource :user_info, only: :show

  namespace :connect do
    resource :facebook, only: :show
    resource :google,   only: :show
  end

  root to: 'top#index'
end
