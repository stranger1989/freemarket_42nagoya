class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :require_no_authentication, only: [ :create]
  layout 'layout_for_UserAdmin_SignUp'
# リダイレクト先のパスを格納
  @@url = ""
# エラー処理のため、遷移前のページ格納
  @@before_url = ""

# 会員登録トップページ
  def index
  end
# 基本情報作成
  def basic_information
    build_resource
    yield resource if block_given?
    respond_with resource
    @@url = "residence"
  end
# 住所情報作成
  def residence
    build_resource
    yield resource if block_given?
    respond_with resource
    @@url = "payment"
  end
# payjpの情報受け渡し、フォームはpayjpにて作成
  def payment
  end
# payjpに顧客情報を登録したあと登録完了
  def finish
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    customer = Payjp::Customer.create(
      :card  => params['payjp-token']
    )
    if customer[:id]
      total_signup_params({ payment: customer[:id] })
      build_resource(total_signup_params)
      resource.save
      error_message(resource)
    else
      render 'payment'
    end
  end

  def create
    @@total_signup_params = User.set_default_params() if @@before_url == ""
    total_signup_params(sign_up_params)
    build_resource(total_signup_params)
    if URI(request.referer).path == "/users"
      path = @@before_url
    else
      @@before_url = Rails.application.routes.recognize_path(request.referer)[:action]
      path = @@before_url
    end
    if path != "payment"
      if resource.valid? == true
        redirect_to action: @@url
      else
        error_message(path)
      end
    end
  end

  protected

  def total_signup_params(sign_up_params={})
    @@total_signup_params = @@total_signup_params.merge(sign_up_params)
    return @@total_signup_params
  end

  def error_message(redirect_path)
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      render redirect_path
    end
  end

end
