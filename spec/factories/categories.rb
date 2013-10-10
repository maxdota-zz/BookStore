require 'faker'

FactoryGirl.define do 
  factory :category do |b|
    b.name { Faker::Name.title }
  end
end