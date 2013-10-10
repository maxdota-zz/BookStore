require 'faker'

FactoryGirl.define do 
  factory :user do |f|
    f.full_name { Faker::Name.name }
    f.username { Faker::Name.name }
    f.password { |i| i }
    f.password_confirmation { |i| i }
    f.email_address "abc@something.com"
    f.phone "01345678978"
    
    factory :normal_user do |f|
      f.role "normal"
      f.activation true
    end
  
    factory :inactivated_user do |f|
      f.role "normal"
      f.activation false
    end
    
    factory :admin do |f|
      f.role "admin"
      f.activation true
    end
  end  
end