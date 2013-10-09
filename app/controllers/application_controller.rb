class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :user_authorize, :admin_authorize
  
  protected
    def admin_authorize
      if !User.find_by_id(session[:user_id]) || session[:role] != "admin"
        redirect_to store_url, :notice => "Access restricted."
      end
    end
    def user_authorize
      if !User.find_by_id(session[:user_id])
        redirect_to login_url, :notice => "Please login."
      end
    end
end
