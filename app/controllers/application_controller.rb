class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    user = User.find_by(session_token: session[:session_token])
    return nil unless user
    user
  end

  def log_in!(user)
    session[:session_token] = user.reset_session_token!
  end

  def log_out!(user)
    session[:session_token] = nil
    user.reset_session_token!
  end

  def logged_in?
    !!current_user
  end

  def ensure_logged_in
    redirect_to new_session_url unless logged_in?
  end

  def ensure_not_logged_in
    redirect_to bands_url if logged_in?
  end
end
