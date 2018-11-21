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
    flash.clear

    user = User.find_by_email(sign_in_params['email'])
    super and return unless user
    puts user.failed_attempts
    puts User.logins_before_captcha
    adjust_failed_attempts(user)
    puts user.failed_attempts
    puts User.logins_before_captcha
    super and return if (user.failed_attempts < User.logins_before_captcha)
    super and return if user.access_locked? or verify_recaptcha

    # Don't increase failed attempts if Recaptcha was not passed
    decrement_failed_attempts(user) if recaptcha_present?(params) and
        !verify_recaptcha

    # Recaptcha was wrong
    self.resource = resource_class.new(sign_in_params)
    sign_out
    flash[:error] = 'Captcha was wrong, please try again.'
    respond_with_navigational(resource) { render :new }

    activity('user sign in')
  end

  # DELETE /resource/sign_out
  def destroy
    activity('user sign out')
    super
  end

  def after_sign_in_path_for(resource)
    resource.update cached_failed_attempts: 0, failed_attempts: 0
    root_path
  end

  private
  def adjust_failed_attempts(user)
    puts user.failed_attempts
    puts user.cached_failed_attempts
    if user.failed_attempts > user.cached_failed_attempts
      user.update cached_failed_attempts: user.failed_attempts
    else
      increment_failed_attempts(user)
    end
  end

  def increment_failed_attempts(user)
    user.increment :cached_failed_attempts
    user.update failed_attempts: user.cached_failed_attempts
  end

  def decrement_failed_attempts(user)
    user.decrement :cached_failed_attempts
    user.update failed_attempts: user.cached_failed_attempts
  end

  def recaptcha_present?(params)
    params[:recaptcha_challenge_field]
  end

  def check_captcha
    unless verify_recaptcha
      self.resource = resource_class.new sign_up_params
      resource.validate # Look for any other validation errors besides Recaptcha
      set_minimum_password_length
      respond_with resource
    end
  end


  # def check_captcha
  #   cookies[:login_attempts] ||= 0
  #   cookies[:login_attempts] = cookies[:login_attempts].to_i + 1
  #   if cookies[:login_attempts].to_i > 3
  #     unless verify_recaptcha
  #       self.resource = resource_class.new sign_up_params
  #       resource.validate # Look for any other validation errors besides Recaptcha
  #       set_minimum_password_length
  #       respond_with resource
  #     end
  #   end
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
