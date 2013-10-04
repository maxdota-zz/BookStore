Given(/^there is a book named "([^\"]*)"$/) do |name|
  @book = Book.new
  @book.title = name
end
    
And(/^the book's author is "([^\"]*)"$/) do |author|
  @book.author_name = author
end

And(/^the book's other's attribute is auto-generated$/) do

end