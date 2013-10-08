Given(/^there is a category named "([^\"]*)"$/) do |name|
  @category = Category.new
  @category.name = name
  @category.save 
end

Given (/^the book "([^\"]*)" belongs to the category "([^\"]*)"$/) do |book, category|
  @book = Book.find_by_title(book)
  @category = Category.find_by_name(category)  
  @item = @category.add_book(@book.id)
  @item.save
end