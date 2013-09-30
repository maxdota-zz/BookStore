require 'spec_helper'

describe "StaticPages" do
  describe "Home page" do
    it "should have the content 'Welcome aboard'" do
      visit '/'
      expect(page).to have_content('Welcome aboard')
    end
  end

  describe "Registration page" do
    it "should have content 'Registration'" do
      visit users_url + '/new'
      expect(page).to have_content('Registration')
    end
  end
end
