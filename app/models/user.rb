require 'gmail'

class User < ActiveRecord::Base
  attr_accessible :username, :role, :activation, :account_creation_date, :birthday, :email_address, :full_name, :password_digest, :phone, :password, :password_confirmation, :active_code
  validates :email_address, :full_name, :username, presence: true
  validates :username, uniqueness: true
  validates :email_address, format: {
    with: %r{\w+@\w+\.com$}i,
    message: 'must be in format xxx@xxx.com'
  }
  validates :phone, format: {
    with: %r{0[0-9][0-9][0-9][0-9][0-9][0-9][0-9]+}i,
    message: 'must be in format 0xxxxxxxx (all digits)'
  }

  has_secure_password

  def send_activation_email(name, account, email_address, activate_link)
    gmail = Gmail.new("ngoc.nguyen@stanyangroup.com", "hongngoc92")
      gmail.deliver do
        to email_address 
        subject "Max's Online Bookstore Account Activation"
        text_part do
          body "Welcome to Max's Online Bookstore, " + name + "
          Please copy the following link and paste them to the browser address bar to activate your account: 
          " + activate_link
        end
        html_part do
          body "<p>Welcome to Max's Online Bookstore, " + name + "</p>
          <p>You have recently registered account " + account + "</p>
          <p>Please click the following link to activate your account: </p>
          <a href='" + activate_link + "'> Activate Account </a>"
        end
      end
  end
end
