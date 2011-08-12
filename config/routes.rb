OpenidConnectSample::Application.routes.draw do
  resource :facebook,  only: :show
  resource :session,   only: :destroy
  resource :dashboard, only: :show
  resources :clients,  only: [:show, :new, :create, :destroy]

  root to: 'top#index'
end
