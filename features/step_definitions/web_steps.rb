When /^(?:|I )go to (.+)$/ do |page_name|
  case page_name
  when "the homepage"
    then visit store_path
  when "register page"
    then visit new_user_url
  when "the login page"
    then visit login_url
  when "the users page"
    then visit users_url
  else
    raise "UNEXPECTED PAGE TO VISIT"  
  end
end

When /^I click on "([^\"]*)"$/ do |name|
  click_link name
end

When (/^I change the ([^\"]*) to ([^\"]*)$/) do |field, value|
  select(value, :from => field)
end

When (/^I choose ([^\"]*) in the ([^\"]*)$/) do |value, field|
  choose(value)
end

When /^I reload the page$/ do
  visit current_path
end