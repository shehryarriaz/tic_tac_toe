class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user
  private
  def current_user
    begin
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound 
      session[:user_id] = nil
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to new_session_path, alert: "Sorry - You do not have permission to view this page"
  end
end
