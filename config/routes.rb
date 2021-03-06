Rails.application.routes.draw do
  devise_for :users, controllers: {
        registrations: 'users/registrations',
        omniauth_callbacks: 'users/omniauth_callbacks'
      }

  root "items#index"
  resources :items, only: [:index, :show, :new, :create, :update, :destroy] do
    resources :orders, only: [:new, :create]
    get '/:name', controller: 'items', action: 'edit'
    get 'search', on: :collection
  end



  devise_scope :user do
    get "/users/sign_up/registration", to: "users/registrations#index", as: "user_registration_index"
    get "/users/sign_up/basic-infomation", to: "users/registrations#basic_information", as: "user_registration_basic_infomation"
    get "/users/sign_up/sns-basic-infomation", to: "users/registrations#sns_basic_information", as: "user_registration_sns_basic_infomation"
    get "/users/sign_up/residence", to: "users/registrations#residence", as: "user_registration_residence"
    get "/users/sign_up/payment", to: "users/registrations#payment", as: "user_registration_payment"
    post '/users/sign_up/payment/finish', to: "users/registrations#finish", as: "user_registration_finish"
    patch 'users/:name', controller: 'users/registrations', action: 'update'
  end

  resource :users, only: [:show, :update]

  get 'users/:name', controller: 'users', action: 'edit'
  get 'users/:name', controller: 'users/registrations', action: 'edit'
end
