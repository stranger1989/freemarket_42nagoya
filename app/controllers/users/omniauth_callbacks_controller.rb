class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    # facebookをコールバック
    callback_from :facebook
  end

  def google_oauth2
    # googleをコールバック
    callback_from :google
  end

  private

  def callback_from(provider)
    provider = provider.to_s
    # request.env['omniauth.auth']はユーザ情報
    @user = User.find_for_oauth(request.env['omniauth.auth'])
    # facebookユーザー認証が通った場合
    if @user.persisted?
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
      session[:sns_information] = request.env['omniauth.auth'].uid
      # snsconfidencialsテーブルにユーザが登録されている場合ログインする
      if SnsCredential.find_by(uid: session[:sns_information]).user_id
        sign_in_and_redirect User.find(@user.user_id), event: :authentication
      # それ以外の時、ユーザー情報を入力
      else
        redirect_to user_registration_sns_basic_infomation_url
      end
    # facebookユーザー認証が通らなかった場合
    else
      session["devise.#{provider}_data"] = request.env['omniauth.auth']
      redirect_to user_registration_index_url
      flash[:notice_facebook_registration] = "facebookの認証に失敗しました"
      flash[:notice_google_registration] = "googleの認証に失敗しました"
    end
  end

end
