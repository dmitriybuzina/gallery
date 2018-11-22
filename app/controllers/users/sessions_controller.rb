# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  #
  # before_action :check_captcha, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    if recaptcha_present?(params) && !verify_recaptcha
      self.resource = resource_class.new(sign_in_params)
      sign_out
      render :new
    elsif super
      activity('user sign in')
    end
  end

  # DELETE /resource/sign_out
  def destroy
    activity('user sign out')
    super
  end

  private
  def decrement_failed_attempts(user)
    user.update!(failed_attempts: user.failed_attempts - 1)
  end

  def recaptcha_present?(params)
    params['g-recaptcha-response']
  end

  def check_captcha
    unless verify_recaptcha
      self.resource = resource_class.new sign_up_params
      resource.validate # Look for any other validation errors besides Recaptcha
      set_minimum_password_length
      respond_with resource
    end
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
