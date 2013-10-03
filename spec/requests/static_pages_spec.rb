require 'spec_helper'

describe "StaticPages" do
  describe "Home page" do
    it "should have the content 'Catalog'" do
      visit store_url(nil)
      expect(page).to have_content('Catalog')
    end
  end

  describe "Registration page" do
    it "should have content 'Registration'" do
      visit new_user_url
      expect(page).to have_content('Registration')
    end
  end
end
