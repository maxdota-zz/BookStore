Feature: Edit account's information
  As an activated user,
  I want to be able to edit my personal's information
  And change email address after I enter my password
  And change password after I enter my current password
  
  Background: 
    Given there is a user with username "admin"
    And the password is "a"
    And the activation status is "activated"
    And the role is "admin"
    And the other's information of this user is auto-gererated
    Given there is a user with username "user"
    And the password is "u"
    And the activation status is "activated"
    And the role is "normal"
    And the other's information of this user is auto-gererated
    When I log in as user|u
  
  Scenario: Edit personal's information
    When I click on "edit"    
    And I fill in user_full_name with Nguyen Ngoc
    And I fill in user_username with n
    And I fill in user_phone with 0123456789
    And I change the user_birthday_1i to 1992
    And I change the user_birthday_2i to June
    And I change the user_birthday_3i to 15    
    And I press the Update User button
    Then The notice display should be User's information was successfully updated.
    And user n information should be changed
    And user's full name should be Nguyen Ngoc
    And user's phone should be 0123456789
    And user's birthday should be 1992/06/15
    
  Scenario Outline: Change email address
    When I click on "change_email"    
    And I fill in user_password with <password>
    And I fill in user_email_address with <new_email>    
    And I press the Change button
    Then The notice display should be <notice>
    And user n information <result> be changed    
    And user's email address should be <result_email>
    
    Scenarios: with incorrect password
    | password | new_email     | notice              | result     | result_email |
    | WRONG    | abc@yahoo.com | Incorrect password. | should not |              |    
    Scenarios: with wrong format of email address
    | password | new_email  | notice                     | result     | result_email |
    | u        | abc.com    | Invalid new email address. | should not |              |    
    Scenarios: with correct password and correct format of email address
    | password | new_email        | notice                                 | result | result_email  |
    | u        | abc@yahoo.com    | Email address is changed successfully. | should | abc@yahoo.com |
    
  Scenario Outline: Change password
    When I click on "change_password"    
    And I fill in old_password with <old_password>
    And I fill in new_password with <new_password>
    And I fill in confirm_password with <confirm_password>  
    And I press the Change button
    Then The notice display should be <notice>
    And user n information <result> be changed    
    And user's password should be <result_password>
    
    Scenarios: with incorrect old password
    | old_password | new_password | confirm_password | notice              | result     | result_password |
    | WRONG        | a            | a                | Incorrect password. | should not |                 |
    Scenarios: with different new password and password confirmation
    | old_password | new_password | confirm_password | notice              | result     | result_password |
    | u            | a            | b                | New password and its confirmation do not match. | should not ||    
    Scenarios: with valid input
    | old_password | new_password | confirm_password | notice                           | result | result_password |
    | u            | a            | a                | Password is change successfully. | should | a               |