class UsersController < ApplicationController
 # skip_before_filter :user_authorize, :admin_authorize
  
  skip_before_filter :user_authorize, :only => [:password_reset, :password_reset_result, :activate, :create, :new]
  skip_before_filter :admin_authorize, :only => [:password_reset, :password_reset_result, :activate, :create, :new, :change_email, :change_password, :update, :edit]
  include SimpleCaptcha::ControllerHelpers

  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def activate
    @code = params[:token]
    @user = User.find_by_tokenized_code(@code)
    if @user
      @user.update_attribute("activation", true)
      @user.update_attribute("tokenized_code", "")
      session[:role] = @user.role
      session[:user_id] = @user.id 
      flash[:notice] = "Activation completed."
    end

    respond_to do |format|
      format.html 
      format.json { render :json => @user, :status => :created, :location => @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/1/edit
  def edit
    if session[:role] != "admin" && params[:id] != session[:user_id].to_s
      redirect_to store_url, :notice => "Access restricted."
    else
      @user = User.find(params[:id])
    end
  end

  # POST /users
  # POST /users.json
  def create
    if simple_captcha_valid?
      @user = User.new(params[:user]) 
      respond_to do |format|
        if @user.save
          @user.send_activation_email(@user.full_name, @user.username, @user.email_address, activate_url(@user.tokenized_code))
          format.html { redirect_to login_url, :notice => "Registration completed. Please check your email to activate the account." }
          format.json { render :json => @user, :status => :created, :location => @user }
        else
          format.html { render :action => "new" }
          format.json { render :json => @user.errors, :status => :unprocessable_entity }
        end
      end
    else    
      redirect_to new_user_url, :notice => "The letters you entered do not match the image."
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])
    if session[:role] != "admin" && params[:id] != session[:user_id].to_s
      redirect_to store_url, :notice => "Access restricted."
    else
    if simple_captcha_valid?
      respond_to do |format|
        if @user.update_attributes(params[:user])
          format.html { redirect_to store_url, :notice => "User's information was successfully updated." }
          format.json { head :no_content }
        else
          format.html { render :action => "edit" }
          format.json { render :json => @user.errors, :status => :unprocessable_entity }
        end
      end
    else
      redirect_to edit_user_url(@user), :notice => "The letters you entered do not match the image."
    end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    begin
      @user.destroy
    rescue Exception => e
      flash[:notice] = e.message
    end
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def upgrade
    @user = User.find(params[:id])
    respond_to do |format|
      if !@user.activation    
        format.html { redirect_to users_url, :notice => "User that is not activated cannot become admin." }
        format.json { head :no_content }      
      elsif @user.update_attribute("role", "admin")
        format.html { redirect_to users_url, :notice => "User was successfully upgraded to admin." }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user.errors, :notice => :unprocessable_entity }
      end
    end
  end

  def downgrade
    user = User.find(params[:id])
    respond_to do |format|
      begin
        if user.update_attribute("role", "normal")
          format.html { redirect_to users_url, :notice => "User was successfully downgraded to normal." }
          format.json { head :no_content }
        else
          format.html { render :action => "edit" }
          format.json { render :json => user.errors, :status => :unprocessable_entity }
        end
      rescue Exception => e
        flash[:notice] = e.message
        format.html { redirect_to users_url }
      end
    end
  end

  def password_reset_result
    if (request.get?)
      @code = params[:token]
      @user = User.find_by_tokenized_code(@code)
      if @user and @user.activation
        session[:code] = @code
        session[:temp_username] = @user.username
        flash[:notice] = "Correct token code."
      else        
        flash[:notice] = "Incorrect token code."
      end
    else
      @user_info = User.new(params[:user])
      respond_to do |format|
        if @user_info.password != @user_info.password_confirmation
          format.html { redirect_to reset_result_path(session[:code]), :notice => "Password confirmation does not match the password." }    
        else          
          @user = User.find_by_username(session[:temp_username])
          @user.change_password(@user_info.password)
          @user.update_attribute("tokenized_code", "")
          session[:code] = nil
          session[:temp_username] = nil    
          session[:role] = @user.role
          session[:user_id] = @user.id 
          format.html { redirect_to users_url, :notice => "New password has been set." }
        end
      end
    end
  end

  def password_reset
    if (request.post?)
      if simple_captcha_valid?
        @user_info = User.new(params[:user])
        @user = User.find_by_username(@user_info.username)
        respond_to do |format|
          if !@user or @user.email_address != @user_info.email_address
            format.html { redirect_to password_reset_url, :notice => "Incorrect username/email address combination." }
          elsif !@user.activation
            format.html { redirect_to password_reset_url, :notice => "This account is not activated." }          
          else
            @user.add_token
            @user.send_password_reset_email(reset_result_url(@user.tokenized_code))
            format.html { redirect_to password_reset_url, :notice => "Please check your email to reset the password." }
          end
        end
      else
        redirect_to password_reset_url, :notice => "The letters you entered does not match the image."
      end
    else
      @user = User.new
    end
  end
  
  def change_email    
    if (request.post?)
      @user_info = User.new(params[:user])
      @user = User.find(session[:user_id])
      if @user.authenticate(@user_info.password)
        @user_info.valid?
        if @user_info.errors.include?(:email_address)
          redirect_to change_email_address_url, :notice => "Invalid new email address."
        else
          @user.update_attribute("email_address", @user_info.email_address)
          redirect_to store_url, :notice => "Email address is changed successfully."
        end
      else
        redirect_to change_email_address_url, :notice => "Incorrect password."
      end
    end
    @user = User.new
  end
  
  def change_password  
    if (request.post?)
      @user = User.find(session[:user_id])
      if @user.authenticate(params[:old_password])
        @user.password = params[:new_password]
        @user.password_confirmation = params[:confirm_password]
        if @user.valid?
          @user.change_password(params[:new_password])
          redirect_to store_url, :notice => "Password is change successfully."
        else          
          redirect_to change_password_url, :notice => "New password and its confirmation do not match."
        end
      else
        redirect_to change_password_url, :notice => "Incorrect password."
      end
    end
  end
end
