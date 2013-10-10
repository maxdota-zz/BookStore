require 'spec_helper'

describe UsersController do
  let(:admin) { FactoryGirl.create(:admin) }
  let(:user) { FactoryGirl.create(:normal_user) }
  let(:inactivated_user) { FactoryGirl.create(:inactivated_user) }
  before do
    User.delete_all
    session[:user_id] = admin.id
    session[:role] = "admin"
    user
  end
  
  describe "Edit account" do
    context "Change email" do
      before do
        session[:user_id] = user.id        
      end
      it "should deny invalid password" do
        post :change_email, :user => {:password => "WRONG", :email_address => "abc@yahoo.com"}        
        response.should redirect_to change_email_address_url
        expect(flash[:notice]).to have_content("Incorrect password.")
      end
      it "should deny invalid email address" do
        post :change_email, :user => {:password => user.password, :email_address => "abc.com"}  
        response.should redirect_to change_email_address_url      
        expect(flash[:notice]).to have_content("Invalid new email address.")
      end
      it "should change email address" do
        post :change_email, :user => {:password => user.password, :email_address => "abc@yahoo.com"}  
        response.should redirect_to store_url      
        expect(flash[:notice]).to have_content("Email address is changed successfully.")
        user.reload
        user.email_address.should == "abc@yahoo.com"
      end
    end
    
    context "Change password" do
      before do
        session[:user_id] = user.id        
      end
      it "should deny invalid password" do
        post :change_password, :old_password => "WRONG", :new_password => "a", :confirm_password => "a"     
        response.should redirect_to change_password_url
        expect(flash[:notice]).to have_content("Incorrect password.")
      end
      it "should deny different password and password confirmation" do
        post :change_password, :old_password => user.password, :new_password => "b", :confirm_password => "a"
        response.should redirect_to change_password_url      
        expect(flash[:notice]).to have_content("New password and its confirmation do not match.")
      end
      it "should change password" do
        post :change_password, :old_password => user.password, :new_password => "a", :confirm_password => "a"
        response.should redirect_to store_url      
        expect(flash[:notice]).to have_content("Password is change successfully.")
        user.reload
        user.authenticate("a").should_not == false
      end      
    end
    
    context "Update personal information" do
      it "should update phone number" do
        put :update, :id => user.id, :user => { :phone => "0123456789" }
        user.reload
        user.phone.should == "0123456789"        
      end
      it "should update full name" do        
        put :update, :id => user.id, :user => { :full_name => "Jo John" }
        user.reload
        user.full_name.should == "Jo John"
      end
    end
  end
  
  context "Reset password" do
    before do      
      post :password_reset, :user => {"username" => admin.username, "email_address" => admin.email_address}
    end
    it "should trigger the reset when being requested by creating a token code" do     
      admin.reload
      admin.tokenized_code.should_not == ""
    end
    it "should accept the correct token code" do
      get :password_reset_result, :token => User.find(admin.id).tokenized_code
      expect(flash[:notice]).to have_content("Correct token code.")
    end
    it "should reject the incorrect token code" do
      get :password_reset_result, :token => "WRONG"
      expect(flash[:notice]).to have_content("Incorrect token code.")
    end
    it "should reject when the password is different from password confirmation" do
      get :password_reset_result, :token => User.find(admin.id).tokenized_code
      post :password_reset_result, :user => {"password" => "new", "password_confirmation" => "old"}   
      expect(flash[:notice]).to have_content("Password confirmation does not match the password.")
      admin.reload
      admin.authenticate("new").should == false
    end
    it "should change the password" do
      get :password_reset_result, :token => User.find(admin.id).tokenized_code
      post :password_reset_result, :user => {"password" => "new", "password_confirmation" => "new"}   
      expect(flash[:notice]).to have_content("New password has been set.")      
      admin.reload
      admin.authenticate("new").should_not == false
    end
  end
  
  it "should add new registered user and redirect to login page" do
    expect {      
      post :create, :user => FactoryGirl.attributes_for(:inactivated_user)
    }.to change { User.count }.by(1)
    response.should redirect_to login_url
  end
  
  context "Manage role" do
    it "should raise error when downgrading the last admin" do
      get :downgrade, :id => admin.id
      response.should redirect_to users_url
      expect(flash[:notice]).to have_content("Can't delete/downgrade the last admin")
    end
    it "should raise error when upgrading inactivated user to admin" do
      get :upgrade, :id => inactivated_user.id
      response.should redirect_to users_url
      expect(flash[:notice]).to have_content("User that is not activated cannot become admin.")
    end
    it "should upgrade normal user to admin" do
      get :upgrade, :id => user.id
      user.reload
      user.role.should == "admin"
    end
    it "should downgrade admin to normal user" do
      get :upgrade, :id => user.id
      get :downgrade, :id => admin.id
      expect(flash[:notice]).to have_content("User was successfully downgraded to normal.")
      admin.reload
      admin.role.should == "normal"
    end
  end
  
  context "Delete" do
    it "should destroy user" do
      expect {
        delete :destroy, :id => user.id
      }.to change { User.count }.by(-1)
      response.should redirect_to users_url
    end
    it "should raise error when deleting the last admin" do
      delete :destroy, :id => admin.id
      response.should redirect_to users_url
      expect(flash[:notice]).to have_content("Can't delete/downgrade the last admin")
    end
  end
  
  context "Register" do      
    it "asks user to activate by email after completed" do
      post :create, :user => FactoryGirl.attributes_for(:inactivated_user)
      expect(flash[:notice]).to have_content("Please check your email to activate the account")
    end      
    it "activates user by token code" do
      inactivated_user.activation.should == false
      get :activate, :token => inactivated_user.tokenized_code
      expect(flash[:notice]).to have_content("Activation completed.")
      inactivated_user.reload
      inactivated_user.activation.should == true
      inactivated_user.tokenized_code.should == ""
    end
  end
end

