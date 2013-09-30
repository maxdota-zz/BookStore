require 'spec_helper'

describe User do
  before do
    @user = FactoryGirl.create(:user)
  end

  it "has a valid factory" do
    @user.should be_valid
  end

  it "is invalid without a username" do
    @user.username = nil
    @user.should_not be_valid
  end

  it "is invalid without a full name" do
    @user.full_name = nil
    @user.should_not be_valid
  end

  it "is invalid without a password" do
    @user.password_digest = nil
    @user.should_not be_valid
  end

  it "is invalid without an email address" do
    @user.email_address = nil
    @user.should_not be_valid
  end

  it "is invalid without a phone number" do
    @user.phone = nil
    @user.should_not be_valid
  end

  it "is invalid with a phone number contains letter" do
    @user.phone = "0986586g"
    @user.should_not be_valid
  end

  it "is invalid with a short phone number " do
    @user.phone = "025"
    @user.should_not be_valid
  end

  it "is invalid with a non-zero at start phone number " do
    @user.phone = "48698654"
    @user.should_not be_valid
  end

  it "is invalid with an invalid email address " do
    @user.email_address = "hello world"
    @user.should_not be_valid
  end
end