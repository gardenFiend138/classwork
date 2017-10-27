Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :cats, except: :destroy
  resources :cat_rental_requests, only: [:new, :create] do
    post 'approve', on: :member
    post 'deny', on: :member
  end

  root to: redirect('/cats')

  #allowing user to only create account, not allowing them to destroy account
  resources :users, only: [:create, :new]

  #using singular resource because we don't want id in PATH for destroy
  #(refer to rails routes in terminal)
  resource :session, only: [:new, :create, :destroy]
end
