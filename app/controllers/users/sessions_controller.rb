# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    p 'into user new'
    @user = User.new
  end

  # POST /resource/sign_in
  def create
    super
    # @user = User.where(:email = allowed_params[:email])
    # p 'into user create'
    # p allowed_params
    # @user = User.create(allowed_params)
    # if @user.errors.empty?
    #   p '!!!! User were saved !!!!'
    #   redirect_to welcome_path
    # else
    #   p '================ Error while saving the user ================'
    #   p @user.errors
    # end
  end

  # DELETE /resource/sign_out
  def destroy
    p 'into user new'
    super
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end

  def allowed_params
    params.require(:user).permit(:email, :password)
  end

end
