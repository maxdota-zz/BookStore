Feature: Browse the store at homepage 
  As an anonymous user,
  I want to be able to view the store in homepage
  And see books of different categories

Background:
  Given there is a category named "Technology"
  And there is a book named "Programming Ruby 1.9"
  And the book's author is "Somebody"
  And the book's other's attribute is auto-generated
  And the book "Programming Ruby 1.9" belongs to the category "Technology"
  When I go to the homepage

Scenario: Homepage layout
   Then I should see the homepage rendered
   And I should see the category "Technology"
   And I should see the book "Programming Ruby 1.9"
# Scenario: Layout and content
#   Then I should see the homepage rendered
#   And there is a client called "soChange" listed
#   And there is a member called "Tien Le" listed

# Scenario: Profile detail
#   And I scroll to "employees"
#   And I click on ".member-info"
#   Then "Tien Le" member profile dialog is visible
#   And I should see "Skills: RoR, Projects: soChange"

# Scenario: Fill in invalid information in training form
#   And I fill in the following:
#     | training_application[background]     | background     |
#     | training_application[elevator_pitch] | evalator pitch |
#     | training_application[goals]          | goals          |
#     | training_application[name]           | Peter          |
#     | training_application[email]          | invalid email  |
#     | training_application[start_date]     |                |
#   And I click on "#new_training_application input[type=submit]"
#   Then I should see "can't be blank"
#   And I should see "is invalid"

# Scenario: Fill in all neccessary information in training form
#   And I fill in the following:
#     | training_application[background]     | background      |
#     | training_application[elevator_pitch] | evalator pitch  |
#     | training_application[goals]          | goals           |
#     | training_application[name]           | Peter           |
#     | training_application[email]          | peter@email.com |
#   And I fill in a valid date in training application form
#   And I click on "#new_training_application input[type=submit]"
#   Then I should see "Thank you. Your application has been submitted."

# Scenario: Fill in invalid information in contact form
#   And I scroll to "new_feedback"
#   And I fill in the following:
#     | feedback[email]     | invalid email     |
#     | feedback[subject]   |                   |
#     | feedback[content]   | feedback message  |
#   And I click on "#new_feedback input[type=submit]"
#   Then I should see "can't be blank"
#   And I should see "is invalid"

# Scenario: Fill in valid information in contact form
#   And I scroll to "new_feedback"
#   And I fill in the following:
#     | feedback[email]     | peter@email.com   |
#     | feedback[subject]   | Feedback title    |
#     | feedback[content]   | Feedback message  |
#   And I click on "#new_feedback input[type=submit]"
#   Then I should see "Thank you for contacting us. You should hear from us shortly."
