class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    return nil unless self.session[:session_token]
    @user ||= User.find_by(session_token: self.session[:session_token])
  end

  def log_in!(user)
    user.reset_session_token!
    self.session[:session_token] = user.session_token
  end

  def logged_in?
    !!current_user
  end

  def log_out!
    self.session[:session_token] = nil
  end

  def require_log_in!
    redirect_to new_session_url unless logged_in?
  end

end
