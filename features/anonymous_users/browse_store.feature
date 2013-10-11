Feature: Browse the store at homepage 
  As an anonymous user,
  I want to be able to view the store in homepage
  And see books of different categories

Background:
  Given there is a category named "Technology"
  And there is a category named "Romance"
  And there is a category named "Food"
  And there is a book named "Programming Ruby 1.9"
  And the book's author is "East Agile"
  And the book's other's attribute is auto-generated
  And there is a book named "Coffee Script"
  And the book's author is "Rail Comp."
  And the book's other's attribute is auto-generated
  And there is a book named "Lovely Cow"
  And the book's author is "Buffalo"
  And the book's other's attribute is auto-generated
  And there is a book named "Delicious Bread"
  And the book's author is "Cooker"
  And the book's other's attribute is auto-generated
  And the book "Coffee Script" belongs to the category "Technology"
  And the book "Programming Ruby 1.9" belongs to the category "Technology"
  And the book "Lovely Cow" belongs to the category "Romance"
  And the book "Delicious Bread" belongs to the category "Food"
  When I go to the homepage

Scenario: Homepage layout
  Then I should see the homepage rendered
  And I should see the category "Technology"
  And I should see the category "Romance"
  And I should see the category "Food"
  And I should see the book "Programming Ruby 1.9"
  And I should see the book "Coffee Script"
  And I should not see the book "Lovely Cow"
  And I should not see the book "Delicious Bread"

Scenario: Browse other category
  When I click on "Romance"
  Then I should not see the book "Programming Ruby 1.9"
  And I should not see the book "Coffee Script"
  And I should see the book "Lovely Cow"
  And I should not see the book "Delicious Bread"

Scenario Outline: Search for book
  When I fill in search_input with <search_input>
  And I choose <search_type> in the search_type
  And I change the search_category to <search_category>
  And I press the search button  
  Then I should see the book <book_see>
  And I should see the book <book_see2>
  And I should not see the book <book_not>
  And I should not see the book <book_not2>
  
  Scenarios: search by title
  | search_input | search_type | search_category | book_see | book_see2 | book_not | book_not2 |
  | co           | title       | All             | "Lovely Cow" | "Coffee Script" | "Programming Ruby 1.9" | "Delicious Bread" |
  
  Scenarios: search by author name
  | search_input | search_type | search_category | book_see | book_see2 | book_not | book_not2 |
  | co           | author      | All             | "Delicious Bread" | "Coffee Script" | "Programming Ruby 1.9" | "Lovely Cow" |
   
  Scenarios: search in a category
  | search_input | search_type | search_category | book_see | book_see2 | book_not | book_not2 |
  | r            | title       | Technology      | "Programming Ruby 1.9" | "Coffee Script" | "Delicious Bread" | "Lovely Cow" |