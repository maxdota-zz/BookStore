Given(/^there is a book named "([^\"]*)"$/) do |name|
  @book = Book.new
  @book.title = name
end
    
Given(/^the book's author is "([^\"]*)"$/) do |author|
  @book.author_name = author
end

Given(/^the book's other's attribute is auto-generated$/) do
  @book = FactoryGirl.create(:book, title: @book.title, author_name: @book.author_name)
end