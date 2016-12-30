class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login
  before_action :require_admin
  before_filter :set_locale

  helper_method :current_user
  helper_method :is_admin?
  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_login
    unless current_user
      redirect_to log_in_path
    end
  end

  def is_admin?
    @is_admin ||= User.find(session[:user_id]).is_admin if session[:user_id]
  end

  def require_admin
    unless is_admin?
      redirect_to root_path
    end
  end

  def set_locale
    I18n.locale = params[:locale] if params[:locale].present?
    puts params[:locale]
  end

  def default_url_options(options = {})
    {locale: I18n.locale}
  end
end
