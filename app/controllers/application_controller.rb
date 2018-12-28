class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :top_categories
  before_action :set_locale

  def activity(action)
    Activity.new(user_id: current_user.id, action: action, url: request.original_url).save
  end

  protected
  def top_categories
    @top_categories = Category.order('counter DESC').limit(5)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :first_name, :last_name, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: [:avatar,:avatar_cache, :remove_avatar, :email, :first_name, :last_name, :phone, :date_of_birthday, :location, :password, :password_confirmation])
  end

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
