# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    @user = User.new
  end

  # POST /resource/sign_in
  def create
    super
    redirect_to welcome_index_path
  end

  # DELETE /resource/sign_out
  def destroy
    super
    # redirect_to 'welcome#index'
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end

  def allowed_params
    params.require(:user).permit(:email, :password, :nickname)
  end

end
