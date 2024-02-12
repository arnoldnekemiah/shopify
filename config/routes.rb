Rails.application.routes.draw do
  root 'products#index'
  
  resources :products, only: [:index, :show, :new, :create] do
    resources :charges, only: [:create]
  end  

  post '/create_checkout_session', to: 'products#create_checkout_session'
end
