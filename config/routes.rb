OpenidConnectSample::Application.routes.draw do
  resources :id_tokens

  resource :facebook,        only: :show
  resource :session,         only: :destroy
  resource :dashboard,       only: :show
  resources :clients,        only: [:new, :create, :destroy]
  resources :authorizations, only: [:new, :create]
  resources :access_tokens,  only: :create

  root to: 'top#index'
end
