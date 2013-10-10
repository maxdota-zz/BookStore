require 'spec_helper'

describe User do
  let!(:admin) { FactoryGirl.create(:admin) }
  let!(:user) { FactoryGirl.create(:normal_user) }
  
  describe "Validations" do    
    it {should validate_presence_of :username}
    it {should validate_uniqueness_of :username}
    it {should validate_presence_of :full_name}
    it {should validate_presence_of :password_digest}
    it {should validate_presence_of :email_address}
    it {should validate_presence_of :phone}
  end

  it "is invalid with a phone number contains letter" do
    user.phone = "0986586g"
    user.should_not be_valid
  end

  it "is invalid with a short phone number " do
    user.phone = "025"
    user.should_not be_valid
  end

  it "is invalid with a non-zero at start phone number " do
    user.phone = "48698654"
    user.should_not be_valid
  end

  it "is invalid with an invalid email address " do
    user.email_address = "hello world"
    user.should_not be_valid
  end
end