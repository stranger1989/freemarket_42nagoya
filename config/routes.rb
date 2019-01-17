Rails.application.routes.draw do
  devise_for :users, controllers: {
        registrations: 'users/registrations'
      }
  get 'items/index'
  root "items#index"

  devise_scope :user do
    get "/users/sign_up/registration", to: "devise/registrations#index", as: "user_registration_index"
    get "/users/sign_up/basic_info", to: "devise/registrations#new", as: "user_registration_basic_info"
  end
end
