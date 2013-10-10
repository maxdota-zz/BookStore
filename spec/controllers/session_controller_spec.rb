require 'spec_helper'

describe SessionController do
  
  let!(:admin) { FactoryGirl.create(:admin) }
  let!(:user) { FactoryGirl.create(:normal_user) }
  let!(:inactivated_user) { FactoryGirl.create(:inactivated_user) }
    
  context "Session" do
    it "should be invalid login with inactivate account" do
      post :create, :username => inactivated_user.username, :password => inactivated_user.password
      expect(flash[:notice]).to have_content("Please activate your account.")
    end
    it "should be invalid login with wrong username/password combination" do  
      post :create, :username => user.username, :password => "WRONG"
      expect(flash[:notice]).to have_content("Invalid username/password combination.")
    end
    it "should welcome user that logins with correct username/password combination" do 
      user.update_attribute("activation", true)
      post :create, :username => user.username, :password => user.password
      expect(flash[:notice]).to have_content("Welcome, #{user.username} (#{user.role} role)")
    end
    it "should destroy when logout" do 
      get :destroy
      session[:user_id].should == nil
      session[:role].should == nil      
    end
  end
end
  
