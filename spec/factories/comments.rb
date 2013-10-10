require 'faker'

FactoryGirl.define do 
  factory :comment do |b|
    b.rating { 1 + rand(5) }
    b.content { Faker::Lorem.paragraph }
  end
end