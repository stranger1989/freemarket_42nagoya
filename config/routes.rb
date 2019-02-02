Rails.application.routes.draw do
  devise_for :users, controllers: {
        registrations: 'users/registrations',
        omniauth_callbacks: 'users/omniauth_callbacks'
      }

  root "items#index"
  resources :items do
    resources :orders, only: [:new, :create]
  end

  devise_scope :user do
    get "/users/sign_up/registration", to: "users/registrations#index", as: "user_registration_index"
    get "/users/sign_up/basic-infomation", to: "users/registrations#basic_information", as: "user_registration_basic_infomation"
    get "/users/sign_up/sns-basic-infomation", to: "users/registrations#sns_basic_information", as: "user_registration_sns_basic_infomation"
    get "/users/sign_up/residence", to: "users/registrations#residence", as: "user_registration_residence"
    get "/users/sign_up/payment", to: "users/registrations#payment", as: "user_registration_payment"
    post '/users/sign_up/payment/finish', to: "users/registrations#finish", as: "user_registration_finish"
  end

  resource :users, only: [:show, :edit, :update] do
    member do
      get :listing
      get :in_progress
      get :completed
      get :deliver_address
      get :credit_card
      get :email_password
      get :identification
      get :sms_confirmation
    end
  end
end
