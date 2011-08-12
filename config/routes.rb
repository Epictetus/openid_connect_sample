OpenidConnectSample::Application.routes.draw do
  resource :facebook,  only: :show
  resource :dashboard, only: :show
  resources :clients,  only: [:show, :new, :create, :destroy]

  root to: 'top#index'
end
