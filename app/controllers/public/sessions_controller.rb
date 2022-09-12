# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  #before_action :configure_permitted_parameters, if: :devise_controller? 郵便番号等ログインに必要なデータの許可
  
  def after_sign_in_path_for(resource) # topページへ遷移
    root_path
  end

  def after_sign_out_path_for(resource) # 顧客ログイン画面へ遷移
    new_customer_session_path
  end
  
  #退会した場合はログインできないメソッドを作成
  
  

  #before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
