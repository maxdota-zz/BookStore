Feature: Admin can manage user
  As an admin
  I want to see a list of users 
  And be able to activate their accounts
  And be able to upgrade/downgrade their roles
  And be able to edit their accounts
  And be able to delete some users
  
  Background:
    Given there is a user with username "admin"
    And the password is "a"
    And the activation status is "activated"
    And the role is "admin"
    And the other's information of this user is auto-gererated
    Given there is a user with username "newuser"
    And the password is "u1"
    And the activation status is "inactivated"
    And the role is "normal"
    And the other's information of this user is auto-gererated
    Given there is a user with username "normaluser"
    And the password is "u2"
    And the activation status is "activated"
    And the role is "normal"
    And the other's information of this user is auto-gererated
    When I log in as admin|a
    When I go to the users page
    
  # Scenario: see list of users
  #   Then I should see user admin
  #   And I should see user newuser
  #   And I should see user admin