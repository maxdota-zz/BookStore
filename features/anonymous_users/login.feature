Feature:  Anonymous users can login
  Anonymous users can login into the system using their credentials any
  time. The system must reject invalid user name and password. [Use 
  Captcha validation if the user fails to enter correct combination of 
  username/password after 3 times.]
  
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
    When I go to the login page

  Scenario Outline: login account
    Given I fill in username with <username>
    And I fill in password with <password>
    Then The notice display should be <notice>

    Scenarios: valid account
      | username            | password | notice                                        |
      | newuser             | u1       | Please activate your account. Contact an admin if you can't get the activation email in your inbox                                   |
      | normaluser          | u2       | Welcome, normal role, normaluser              |
      | admin               | a        | Welcome, admin role, admin                    |


