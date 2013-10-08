require 'faker'

FactoryGirl.define do 
  factory :book do |b|
    b.title { Faker::Name.title }
    b.description { Faker::Lorem.sentences }
    sequence(:photo_url) { |n| "photo-#{n}.png" }
    b.author_name {Faker::Name.name}
    b.publisher_name {Faker::Name.name}
    b.published_date {rand(10.years).ago}
    b.unit_price {Faker::Number.number(2)}
  end
end