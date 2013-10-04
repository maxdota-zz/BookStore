require 'spec_helper'

describe "StaticPages" do

  describe "Registration page" do
    it "should have content 'Registration'" do
      visit new_user_url
      expect(page).to have_content('Registration')
    end
  end
end
