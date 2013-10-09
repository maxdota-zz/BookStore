require 'spec_helper'

describe UsersController do
  
  before do
    User.delete_all
    @admin = FactoryGirl.create(:user, :activation => true)
    @activated_user = FactoryGirl.create(:user, :activation => true, :role => "normal")
    @inactivated_user = FactoryGirl.create(:user, :role => "normal")
    session[:user_id] = @admin.id
    session[:role] = "admin"
  end
  
  context "Edit account" do
    context "Change email" do
      it "should deny invalid password" do
        session[:user_id] = @activated_user.id
        post :change_email, :user => {:password => "WRONG", :email_address => "abc@yahoo.com"}        
        response.should redirect_to change_email_address_url
        flash[:notice].should have_content("Incorrect password.")
      end
      it "should deny invalid email address" do
        session[:user_id] = @activated_user.id
        post :change_email, :user => {:password => @activated_user.password, :email_address => "abc.com"}  
        response.should redirect_to change_email_address_url      
        flash[:notice].should have_content("Invalid new email address.")
      end
      it "should change email address" do
        session[:user_id] = @activated_user.id
        @activated_user.email_address = "abc@yahoo.com"
        post :change_email, :user => {:password => @activated_user.password, :email_address => "abc@yahoo.com"}  
        response.should redirect_to store_url      
        flash[:notice].should have_content("Email address is changed successfully.")
        User.find(@activated_user.id).email_address.should == "abc@yahoo.com"
      end
    end
    
    context "Change password" do
      it "should deny invalid password" do
        session[:user_id] = @activated_user.id
        post :change_password, :old_password => "WRONG", :new_password => "a", :confirm_password => "a"     
        response.should redirect_to change_password_url
        flash[:notice].should have_content("Incorrect password.")
      end
      it "should deny different password and password confirmation" do
        session[:user_id] = @activated_user.id
        post :change_password, :old_password => @activated_user.password, :new_password => "b", :confirm_password => "a"
        response.should redirect_to change_password_url      
        flash[:notice].should have_content("New password and its confirmation do not match.")
      end
      it "should change password" do
        session[:user_id] = @activated_user.id
        @activated_user.email_address = "abc@yahoo.com"
        post :change_password, :old_password => @activated_user.password, :new_password => "a", :confirm_password => "a"
        response.should redirect_to store_url      
        flash[:notice].should have_content("Password is change successfully.")
        User.find(@activated_user.id).authenticate("a").should_not == false
      end      
    end
    
    context "Update personal information" do
      it "should update phone number" do
        put :update, :id => @activated_user.id, :user => { :phone => "0123456789" }
        User.find(@activated_user.id).phone.should == "0123456789"        
      end
      it "should update full name" do        
        put :update, :id => @activated_user.id, :user => { :full_name => "Jo John" }
        User.find(@activated_user.id).full_name.should == "Jo John"
      end
    end
  end

  context "Reset password" do
    it "should reset password via token code" do     
      post :password_reset, :user => {"username" => @admin.username, "email_address" => @admin.email_address}
      @admin = User.find(@admin.id)      
      @admin.tokenized_code.should_not == ""
      get :password_reset_result, :token => @admin.tokenized_code
      flash[:notice].should have_content("Correct token code.")
      post :password_reset_result, :user => {"password" => "new", "password_confirmation" => "old"}   
      flash[:notice].should have_content("Password confirmation does not match the password.")
      @admin = User.find(@admin.id)      
      @admin.tokenized_code.should_not == ""
      @admin.authenticate("new").should == false
      post :password_reset_result, :user => {"password" => "new", "password_confirmation" => "new"}   
      flash[:notice].should have_content("New password has been set.")      
      @admin = User.find(@admin.id)      
      @admin.tokenized_code.should == ""      
      @admin.authenticate("new").should_not == false
    end
  end
  
  it "should add new registered user and redirect to login page" do
    count = User.count
    post :create, :user => FactoryGirl.attributes_for(:user)
    User.count.should == count + 1
    response.should redirect_to login_url
  end
  
  context "Manage role" do
    it "should raise error when downgrading the last admin" do
      get :downgrade, :id => @admin.id
      response.should redirect_to users_url
      flash[:notice].should have_content("Can't delete/downgrade the last admin")
    end
    it "should raise error when upgrading inactivated user to admin" do
      get :upgrade, :id => @inactivated_user.id
      response.should redirect_to users_url
      flash[:notice].should have_content("User that is not activated cannot become admin.")
    end
    it "should upgrade normal user to admin" do
      get :upgrade, :id => @activated_user.id
      @activated_user = User.find(@activated_user.id)
      @activated_user.role.should == "admin"
    end
    it "should downgrade admin to normal user" do
      get :upgrade, :id => @activated_user.id
      get :downgrade, :id => @admin.id
      @admin = User.find(@admin.id)
      flash[:notice].should have_content("User was successfully downgraded to normal.")
      @admin.role.should == "normal"
    end
  end
  
  context "Delete" do
    it "should destroy user" do
      count = User.count
      delete :destroy, :id => @activated_user.id
      User.count.should == count - 1
      response.should redirect_to users_url
    end
    it "should raise error when deleting the last admin" do
      delete :destroy, :id => @admin.id
      response.should redirect_to users_url
      flash[:notice].should have_content("Can't delete/downgrade the last admin")
    end
  end
  
  context "Register" do      
    it "asks user to activate by email after completed" do
      post :create, :user => FactoryGirl.attributes_for(:user)
      flash[:notice].should have_content("Please check your email to activate the account")
    end      
    it "activates user by token code" do
      @inactivated_user.activation.should == false
      get :activate, :token => @inactivated_user.tokenized_code
      flash[:notice].should have_content("Activation completed.")
      @inactivated_user = User.find(@inactivated_user.id)
      @inactivated_user.activation.should == true
      @inactivated_user.tokenized_code.should == ""
    end
  end
end

