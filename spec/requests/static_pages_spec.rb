require 'spec_helper'

describe "StaticPages" do
  describe "Home page" do
    it "should have the content 'User List'" do
      visit '/'
      expect(page).to have_content('User List')
    end
  end

  describe "Registration page" do
    it "should have content 'Registration'" do
      visit users_url + '/new'
      expect(page).to have_content('Registration')
    end
  end
end
