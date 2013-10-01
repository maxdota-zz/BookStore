require 'digest/md5'

class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
  #  @user = User.find(params[:id])
    @code = params[:id]
    @user = User.find_by_tokenized_code(@code)
    if @user
      @user.update_attribute("activation", true)
      @user.update_attribute("tokenized_code", "")
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user, status: :created, location: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    @user.account_creation_date = Date.current
    @user.role = "normal"
    @user.activation = false
    @user.tokenized_code = Digest::MD5.hexdigest(@user.full_name + @user.email_address + rand(1000).to_s + rand(1000).to_s + rand(1000).to_s)
    respond_to do |format|
      if @user.save
        @user.send_activation_email(@user.full_name, @user.username, @user.email_address, users_url + "/" + @user.tokenized_code)
        format.html { redirect_to users_url, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to users_url, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
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
        format.html { redirect_to users_url, notice: 'User that is not activated cannot be upgraded.' }
        format.json { head :no_content }      
      elsif @user.update_attribute("role", "admin")
        format.html { redirect_to users_url, notice: 'User was successfully upgraded to admin.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def downgrade
    @user = User.find(params[:id])
    respond_to do |format|
      begin
        if @user.update_attribute("role", "normal")
          format.html { redirect_to users_url, notice: 'User was successfully downgraded to normal.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      rescue Exception => e
        flash[:notice] = e.message
        format.html { redirect_to users_url }
      end
    end
  end
end
