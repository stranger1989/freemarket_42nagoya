class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  protect_from_forgery with: :exception
  layout :layout_by_resource
  before_action :configure_permitted_parameters, if: :devise_controller?

  def layout_by_resource
    if devise_controller?
      "layout_for_UserAdmin"
    else
      "application"
    end
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
      keys: [:nickname,
             :profile,
             :avatar,
             :lastname,
             :firstname,
             :lastname_kana,
             :firstname_kana,
             :postalcode,
             :prefecture,
             :city,
             :block,
             :building,
             :birthday,
             :phone_number,
             :payment])
  end

  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end
end
