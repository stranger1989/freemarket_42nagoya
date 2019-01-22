class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :require_no_authentication, only: [ :create]
  layout 'layout_for_UserAdmin_SignUp'
# リダイレクト先のパスを格納
  @@url = ""
# エラー処理のため、遷移前のページ格納
  @@before_url = ""
# 全てバリデーションが通るダミーデータを用意し、
# ページ遷移のたび、フォームデータに書き換えつつバリデーションを確認
  @@total_signup_params = {
     nickname: "testname",
     profile: "",
     avatar: "",
     lastname: "手簀戸手簀戸",
     firstname: "手簀戸手簀戸",
     lastname_kana: "テストテスト",
     firstname_kana: "テストテスト",
     postalcode: "000-0000",
     prefecture: "愛知県",
     city: "名古屋市",
     block: "テスト町",
     building: "テストビル",
     birthday: "1989-1-1",
     phone_number: "08000000000",
     payment: "aaaaaaa"
  }
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
      @@total_signup_params = @@total_signup_params.merge({ payment: customer[:id] })
    else
      render 'payment'
    end

    build_resource(@@total_signup_params)
    resource.save
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
      respond_with resource
    end
  end

  def create
    @@total_signup_params = @@total_signup_params.merge(sign_up_params)
    build_resource(@@total_signup_params)
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
          render path
        end
      end
    end
  end

  protected

  def update_needs_confirmation?(resource, previous)
    resource.respond_to?(:pending_reconfirmation?) &&
      resource.pending_reconfirmation? &&
      previous != resource.unconfirmed_email
  end

  def update_resource(resource, params)
    resource.update_with_password(params)
  end

  def build_resource(hash = {})
    self.resource = resource_class.new_with_session(hash, session)
  end

  def sign_up(resource_name, resource)
    sign_in(resource_name, resource)
  end

  def after_sign_up_path_for(resource)
    after_sign_in_path_for(resource) if is_navigational_format?
  end

  def after_inactive_sign_up_path_for(resource)
    scope = Devise::Mapping.find_scope!(resource)
    router_name = Devise.mappings[scope].router_name
    context = router_name ? send(router_name) : self
    context.respond_to?(:root_path) ? context.root_path : "/"
  end

  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up)
  end

  def translation_scope
    'devise.registrations'
  end

end
