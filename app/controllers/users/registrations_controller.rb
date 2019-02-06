class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :require_no_authentication, only: [:create]
  protect_from_forgery except: [:update]
  layout 'layout_for_UserAdmin_SignUp'
  # リダイレクト先のパスを格納
  @@url = ""

  # 会員登録トップページ
  def index
  end
  # 基本情報作成
  def basic_information
    build_resource
    yield resource if block_given?
    respond_with resource
    @@url = "residence"
    # エラー処理のため、遷移前のページ格納
    @@before_url = ""
  end
  # SNSログイン用基本情報作成
  def sns_basic_information
    build_resource
    yield resource if block_given?
    respond_with resource
    @@url = "residence"
    # エラー処理のため、遷移前のページ格納
    @@before_url = ""
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
    flash[:notice_registration] = ""
  end
  # payjpに顧客情報を登録したあと登録完了
  def finish
    begin
      User.transaction do
        Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
        customer = Payjp::Customer.create(
          :card  => params['payjp-token']
        )
        total_signup_params({ payment: customer[:id] })
        build_resource(total_signup_params)
        resource.save!
      end
      # もしSNSログインの場合、現在登録したユーザーをsnscredentialに登録
      SnsCredential.where(uid: session[:sns_information]).update(user_id: resource.id) if session[:sns_information]
      error_message(resource)
    # クレジット登録がうまくいかなかった時
    rescue Payjp::InvalidRequestError => e
      Rails.logger.debug e.json_body[:error][:message]
      flash[:notice_registration] = "クレジットカードの登録に失敗しました"
    # paramsの受け渡しが上手くいかなかった時
    rescue => e
      Rails.logger.debug e.message
      flash[:notice_registration] = "通信に失敗しました"
      render 'payment'
    end
  end

  def create
    session[:user_information] = User::DEFAULT_USERPARAMS if @@before_url == ""
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

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
    session[:user_update] = UsersRegistrations::PostService.update_creditcard!(account_update_params, params)
    if UsersRegistrations::PostService.update_success_or_fail!(resource, session[:user_update])
      sign_in resource_name, resource, bypass: true
      flash[:success_update] = "変更しました"
      redirect_to action: "edit", name: File.basename(URI.parse(request.referer).path)
    else
      clean_up_passwords resource
      flash[:fail_update] = "変更に失敗しました"
      redirect_to action: "edit", name: File.basename(URI.parse(request.referer).path)
    end
  end

  protected

  def total_signup_params(sign_up_params={})
    session[:user_information] = session[:user_information].merge(sign_up_params)
    return session[:user_information]
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

  def update_resource(resource, params)
    resource.update_without_current_password(params)
  end

end
