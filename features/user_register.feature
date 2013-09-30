Feature: user registers a new account
  Anonymous users can register for an account in the website.
  Required information includes email, password, phone, full name, birthday.
  All information must be validated accordingly.
  An email will be sent to user [in background] to ask them to activate their account.

  Scenario Outline: register account
    When I go to register page
    Given my email address is <email_address>
    And my username is <username>
    And my password is <password>
    And my password confirmation is <pwd_conf>
    And my phone is <phone> 
    And my full name is <full_name>
    When I submit the form
    Then The registration completed should be <result>

    Scenarios: valid account
      | email_address             | username | password | pwd_conf | phone       | full_name   | result |
      | ngoc.nguyen@eastagile.com | ngoc     | n        | n        | 0123456789  | Nguyen Ngoc | true   |
      | ngo@ab.com                | nn       | n        | n        | 05487894568 | Ngoc        | true   |

    Scenarios: invalid email
      | email_address        | username | password | pwd_conf | phone       | full_name   | result  |
      | ngoc.eastagile.com   | ngoc     | n        | n        | 0123456789  | Nguyen Ngoc | false   |
      | ngo@abc              | nn       | n        | n        | 05487894568 | Ngoc        | false   |

    Scenarios: invalid phone
      | email_address             | username | password | pwd_conf | phone       | full_name   | result  |
      | ngoc.nguyen@eastagile.com | ngoc     | n        | n        | 1532158478  | Nguyen Ngoc | false   |
      | ngo@ab.com                | nn       | n        | n        | 01254       | Ngoc        | false   |

    Scenarios: invalid username
      | email_address             | username | password | pwd_conf | phone       | full_name   | result  |
      | ngoc.nguyen@eastagile.com |          | n        | n        | 0123456789  | Nguyen Ngoc | false   |

    Scenarios: invalid password
      | email_address             | username | password | pwd_conf  | phone       | full_name   | result  |
      | ngoc.nguyen@eastagile.com | ngoc     | n        | nn        | 0123456789  | Nguyen Ngoc | false   |
      | ngo@ab.com                | nn       |          |           | 05487894568 | Ngoc        | false   |

    Scenarios: invalid full name
      | email_address             | username | password | pwd_conf | phone       | full_name   | result  |
      | ngoc.nguyen@eastagile.com | ngoc     | n        | n        | 0123456789  |             | false   |

