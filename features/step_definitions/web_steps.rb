When /^(?:|I )go to (.+)$/ do |page_name|
  case page_name
  when "the homepage"
    then visit store_browse_url(1)
  when "register page"
    then visit new_user_url
  end
end