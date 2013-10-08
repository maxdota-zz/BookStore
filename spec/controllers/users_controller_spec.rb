require 'spec_helper'

describe UsersController do
  
  before do
    User.delete_all
    @user = FactoryGirl.create(:user)
  end

  context "Reset password" do
    it "resets password via token code" do      
      get :activate, :token => @user.tokenized_code
      @user = User.find(@user.id)
      @user.tokenized_code.should == ""
      post :password_reset, :user => {"username" => @user.username, "email_address" => @user.email_address}
      @user = User.find(@user.id)      
      @user.tokenized_code.should_not == ""
      get :password_reset_result, :token => @user.tokenized_code
      flash[:notice].should have_content("Correct token code.")
      post :password_reset_result, :user => {"password" => "new", "password_confirmation" => "old"}   
      flash[:notice].should have_content("Password confirmation does not match the password.")
      @user = User.find(@user.id)      
      @user.tokenized_code.should_not == ""
      @user.authenticate("new").should == false
      post :password_reset_result, :user => {"password" => "new", "password_confirmation" => "new"}   
      flash[:notice].should have_content("New password has been set.")      
      @user = User.find(@user.id)      
      @user.tokenized_code.should == ""      
      @user.authenticate("new").should_not == false
    end
  end
  
  it "should add new registered user and redirect to login page" do
    count = User.count
    post :create, :user => FactoryGirl.attributes_for(:user)
    User.count.should == count + 1
    response.should redirect_to login_url
  end
  
  context "Delete" do
    it "should destroy user" do
      @normal_user = FactoryGirl.create(:user, :role => "normal")
      count = User.count
      delete :destroy, :id => @normal_user.id
      User.count.should == count - 1
      response.should redirect_to users_url
    end
    it "should raise error when deleting the last admin" do
      delete :destroy, :id => @user.id
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
      @user.activation.should == false
      get :activate, :token => @user.tokenized_code
      flash[:notice].should have_content("Activation completed.")
      @user = User.find(@user.id)
      @user.activation.should == true
    end
  end
end

