When(/^I log in as ([^\"]*)\|([^\"]*)$/) do |username, password|
  steps %Q{
    When I go to the login page
    And I fill in username with #{username}
    And I fill in password with #{password}
    And I press the Login button
  }
end

And (/^user ([^\"]*) information (should|should not) be changed$/) do |username, result|
  if result == "should"
    @user = User.find_by_username(username)
  else
    @user = nil
  end
end

And (/^user's full name should be ([^\"]*)$/) do |full_name|
  @user.full_name.should == full_name
end

And (/^user's phone should be ([^\"]*)$/) do |phone|
  @user.phone.should == phone
end

And (/^user's birthday should be ([^\"]*)$/) do |birthday|
  @user.birthday.should == Date.parse(birthday)
end

And (/^user's email address should be ([^\"]*)$/) do |email|
  @user.email.should == email if @user
end

And (/^user's password should be ([^\"]*)$/) do |password|
  @user.authenticate(password).should_not == false if @user
end