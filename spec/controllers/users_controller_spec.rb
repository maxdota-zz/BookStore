require 'spec_helper'

describe UsersController do
  
  before do
    User.delete_all
    @admin = FactoryGirl.create(:user)
    @user = FactoryGirl.create(:user, :role => "normal")
  end

  context "Reset password" do
    it "resets password via token code" do      
      get :activate, :token => @admin.tokenized_code
      @admin = User.find(@admin.id)
      @admin.tokenized_code.should == ""
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
    it "should upgrade normal user to admin" do
      get :upgrade, :id => @user.id
      @user = User.find(@user.id)
      @user.role.should == "admin"
    end
    it "should downgrade admin to normal user" do
      get :downgrade, :id => @admin.id
      @admin = User.find(@admin.id)
      @admin.role.should == "normal"
    end
  end
  
  context "Delete" do
    it "should destroy user" do
      count = User.count
      delete :destroy, :id => @user.id
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
      @admin.activation.should == false
      get :activate, :token => @admin.tokenized_code
      flash[:notice].should have_content("Activation completed.")
      @admin = User.find(@admin.id)
      @admin.activation.should == true
    end
  end
end

