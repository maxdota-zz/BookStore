require 'faker'

FactoryGirl.define do 
  factory :user do |f|
    f.full_name { Faker::Name.name }
    f.username { Faker::Name.name }
    f.password_digest { Faker::Name.first_name }
    f.email_address "abc@something.com"
    f.phone "01345678978"
    f.role "admin"
  #  f.tokenized_code "1bc6d8054c61ecbbf5d62cf4b40c88cc"
  end
end