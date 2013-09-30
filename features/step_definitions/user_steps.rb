When(/^I go to register page$/) do
  visit users_url + '/new'
end

Given(/^my email address is ([^\"]*)$/) do |email|
  @user = User.new
  @user.email_address = email
end

Given(/^my username is ([^\"]*)$/) do |username|
  @user.username = username
end

Given(/^my password is ([^\"]*)$/) do |pass|
  @user.password = pass
end

Given(/^my password confirmation is ([^\"]*)$/) do |pass_conf|
  @user.password_confirmation = pass_conf
end

Given(/^my phone is ([^\"]*)$/) do |phone|
  @user.phone = phone
end

Given(/^my full name is ([^\"]*)$/) do |full_name|
  @user.full_name = full_name
end

When(/^I submit the form$/) do
  @result = (@user.valid?).to_s
end

Then(/^The registration completed should be ([^\"]*)$/) do |result|
  result.should == @result
end