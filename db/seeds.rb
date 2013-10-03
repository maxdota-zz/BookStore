# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(username: 'nn',
  password_digest: '$2a$10$7AUsOhbKHCc2Q.5dvJy97OWYzz.zPd5wNyQSKGqPBFzAyM167pWUm',
  email_address: 'ngoc.nguyen@stanyangroup.com',
  birthday: Date.parse('1992-09-30'),
  account_creation_date: Date.parse('2013-09-30'),
  activation: true,
  role: 'normal',
  phone: '0123456789',
  full_name: 'Nguyen Hong Ngoc'
  )

User.create(username: 'n',
  password_digest: '$2a$10$7AUsOhbKHCc2Q.5dvJy97OWYzz.zPd5wNyQSKGqPBFzAyM167pWUm',
  email_address: 'ngoc.nguyen@stanyangroup.com',
  birthday: Date.parse('1992-09-30'),
  account_creation_date: Date.parse('2013-09-30'),
  activation: true,
  role: 'admin',
  phone: '0123456789',
  full_name: 'Nguyen Hong Ngoc'
  )

Book.delete_all
Book.create(title: 'CoffeeScript',
  description: 
    %{<p>
        CoffeeScript is JavaScript done right. It provides all of JavaScript's
  functionality wrapped in a cleaner, more succinct syntax. In the first
  book on this exciting new language, CoffeeScript guru Trevor Burnham
  shows you how to hold onto all the power and flexibility of JavaScript
  while writing clearer, cleaner, and safer code.
      </p>},
  photo_url:   'cs.jpg',    
  author_name: 'Someone',
  publisher_name: 'East Agile',
  published_date: Date.parse('2013-02-15'),
  unit_price: 36.00)

Book.create(title: 'Programming Ruby 1.9',
  description:
    %{<p>
        Ruby is the fastest growing and most exciting dynamic language
        out there. If you need to get working programs delivered fast,
        you should add Ruby to your toolbox.
      </p>},
  photo_url: 'ruby.jpg',
  author_name: 'Somebody',
  publisher_name: 'East Agile',
  published_date: Date.parse('1990-06-11'),
  unit_price: 49.95)

Book.create(title: 'Rails Test Prescriptions',
  description: 
    %{<p>
        <em>Rails Test Prescriptions</em> is a comprehensive guide to testing
        Rails applications, covering Test-Driven Development from both a
        theoretical perspective (why to test) and from a practical perspective
        (how to test effectively). It covers the core Rails testing tools and
        procedures for Rails 2 and Rails 3, and introduces popular add-ons,
        including Cucumber, Shoulda, Machinist, Mocha, and Rcov.
      </p>},
  photo_url: 'rtp.jpg',
  author_name: 'Simon',
  publisher_name: 'EA',
  published_date: Date.parse('2010-12-22'),
  unit_price: 34.95)

Book.create(title: 'Blubber',
  description: 
    %{<p>
        Blubber is a good name for her, the note from Wendy says about Linda. Jill
        crumples it up and leaves it on the corner of her desk. She doesn't want to
        think about Linda or her dumb report on the whale just now. Jill wants to
        think about Halloween.
      </p>},
  photo_url: 'blub.jpg',
  author_name: 'Judy Blume',
  publisher_name: 'Yearling',
  published_date: Date.parse('1986-09-05'),
  unit_price: 12.05)

Book.create(title: 'The Cay',
  description: 
    %{<p>
        Phillip is excited when the Germans invade the small island of Curaçao. War
        has always been a game to him, and he’s eager to glimpse it firsthand–until
        the freighter he and his mother are traveling to the United States on is
        torpedoed.
      </p>},
  photo_url: 'cay.jpg',
  author_name: 'Theodore Taylor',
  publisher_name: 'Yearling',
  published_date: Date.parse('2002-05-28'),
  unit_price: 7.24)

Book.create(title: 'Radiance',
  description: 
    %{<p>
        Ever's younger sister, Riley, has crossed the bridge into the afterlife and
        has been assigned the task of enticing Radiant Boy, an elusive soul who's been
        haunting a castle in England for centuries, to cross the bridge into the
        afterlife with her.
      </p>},
  photo_url: 'rad.jpg',
  author_name: 'Alyson Noël',
  publisher_name: 'Square Fish',
  published_date: Date.parse('2010-08-31'),
  unit_price: 6.78)


Category.create(name: "Romance",
  sort_order: 2
  )
Category.create(name: "Horror",
  sort_order: 1
  )
Category.create(name: "History",
  sort_order: 3
  )
Category.create(name: "Travel",
  sort_order: 5
  )
Category.create(name: "Adventure",
  sort_order: 4
  )

CategoryItem.create(category_id: 2,
  book_id: 2)
CategoryItem.create(category_id: 2,
  book_id: 4)
CategoryItem.create(category_id: 1,
  book_id: 5)
CategoryItem.create(category_id: 2,
  book_id: 5)
CategoryItem.create(category_id: 3,
  book_id: 6)
CategoryItem.create(category_id: 4,
  book_id: 3)
CategoryItem.create(category_id: 5,
  book_id: 1)