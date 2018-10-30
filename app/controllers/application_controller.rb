class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :first_name, :last_name, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :first_name, :last_name, :phone, :date_of_birthday, :location, :password, :password_confirmation])
  end
end
