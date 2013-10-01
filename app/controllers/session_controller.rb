class SessionController < ApplicationController
  def new
  end

  def create
    user = User.find_by_username(params[:username])
    if !user or !user.authenticate(params[:password])
      redirect_to login_url, alert: "Invalid username/password combination"
    elsif !user.activation
      redirect_to login_url, alert: "Please activate your account. Contact an admin if you can't get the activation email in your inbox"      
    else
      session[:user_id] = user.id
      session[:role] = user.role
      redirect_to users_url, notice: "Welcome, " + session[:role] + " user " + user.username
    end
  end

  def destroy
    session[:user_id] = nil
    session[:role] = nil
    redirect_to users_url, notice: "Logged out"
  end
end