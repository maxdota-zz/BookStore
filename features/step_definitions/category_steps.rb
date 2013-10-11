Given(/^there is a category named "([^\"]*)"$/) do |name|
  @category = Category.new
  @category.name = name
  @category.save 
end

Given (/^the book "([^\"]*)" belongs to the category "([^\"]*)"$/) do |book_title, category_name|
  @book = Book.find_by_title(book_title)
  @category = Category.find_by_name(category_name)  
  @item = @category.add_book(@book.id)
  @item.save
end