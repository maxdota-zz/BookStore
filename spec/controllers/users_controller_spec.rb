require 'spec_helper'


describe UsersController do
  before do
    @user = FactoryGirl.create(:user)
  end
  it "redirect upon save" do
    post :create, user: FactoryGirl.attributes_for(:user)
    response.should redirect_to users_url
  end
end