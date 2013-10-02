# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.delete_all
User.create(username: 'n',
  password_digest: '$2a$10$7AUsOhbKHCc2Q.5dvJy97OWYzz.zPd5wNyQSKGqPBFzAyM167pWUm',
  email_address: 'ngoc.nguyen@stanyangroup.com',
  birthday: Date.parse('1992-09-30'),
  account_creation_date: Date.parse('2013-09-30'),
  activation: true,
  role: 'normal',
  phone: '0123456789',
  full_name: 'Nguyen Hong Ngoc'
  )

User.create(username: 'admin',
  password_digest: '$2a$10$7AUsOhbKHCc2Q.5dvJy97OWYzz.zPd5wNyQSKGqPBFzAyM167pWUm',
  email_address: 'ngoc.nguyen@stanyangroup.com',
  birthday: Date.parse('1992-09-30'),
  account_creation_date: Date.parse('2013-09-30'),
  activation: true,
  role: 'admin',
  phone: '0123456789',
  full_name: 'Nguyen Hong Ngoc'
  )