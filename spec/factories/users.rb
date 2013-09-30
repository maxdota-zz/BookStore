require 'faker'

FactoryGirl.define do 
  factory :user do |f|
    f.full_name { Faker::Name.name }
    f.username { Faker::Name.name }
    f.password_digest { Faker::Name.first_name }
    f.email_address "abc@something.com"
    f.phone "01345678978"
  end
end