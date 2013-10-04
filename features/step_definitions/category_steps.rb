Given(/^there is a category named "([^\"]*)"$/) do |name|
  @category = Category.new
  @category.name = name
  @category.save 
end