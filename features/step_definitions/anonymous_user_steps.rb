Then /^I should see the homepage rendered$/ do
  step %Q{I should see the banner with logo and bookshop name}
  step %Q{I should see the side bar with all tabs}
  step %Q{I should see the search panel}
end


Then /^I should see the banner with logo and bookshop name$/ do
  page.should have_xpath("//*[@id='banner']/img")
  page.should have_xpath("/html/head/title")
end

Then /^I should see the side bar with all tabs$/ do
  page.body.should include("<li><a href=\"" + store_url + "\"><i class=\"icon-home icon-white\"></i> Home</a></li>")
  page.body.should include("<li><a href=\"" + login_url + "\">Log In</a></li>")
  page.body.should include("<li><a href=\"" + new_user_url + "\">Register</a></li>")
  page.body.should include("<li><a href=\"" + password_reset_url + "\">Forgot password?</a></li>")
end

Then /^I should see the search panel$/ do
  page.body.should include("<h3 class=\"sidebar-title\">Search</h3>")
end

And /^print out users$/ do
  @users = User.all
  puts "ABC"
  puts @users.inspect
  puts "TESTING HERE"
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
