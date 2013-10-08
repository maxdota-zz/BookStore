# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

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

Book.delete_all
book1 = Book.create(title: 'CoffeeScript',
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

book2 = Book.create(title: 'Programming Ruby 1.9',
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

book3 = Book.create(title: 'Rails Test Prescriptions',
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

book4 = Book.create(title: 'Blubber',
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

book5 = Book.create(title: 'The Cay',
  description: 
    %{<p>
        Phillip is excited when the Germans invade the small island of Curacao. War
        has always been a game to him, and he's eager to glimpse it firsthand until
        the freighter he and his mother are traveling to the United States on is
        torpedoed.
      </p>},
  photo_url: 'cay.jpg',
  author_name: 'Theodore Taylor',
  publisher_name: 'Yearling',
  published_date: Date.parse('2002-05-28'),
  unit_price: 7.24)

book6 = Book.create(title: 'Radiance',
  description: 
    %{<p>
        Ever's younger sister, Riley, has crossed the bridge into the afterlife and
        has been assigned the task of enticing Radiant Boy, an elusive soul who's been
        haunting a castle in England for centuries, to cross the bridge into the
        afterlife with her.
      </p>},
  photo_url: 'rad.jpg',
  author_name: 'Alyson Noel',
  publisher_name: 'Square Fish',
  published_date: Date.parse('2010-08-31'),
  unit_price: 6.78)

book7 = Book.create(title: 'Freckle Juice',
  description: 
    %{<p>
        Nicky has freckles -- they cover his face, his ears, and the whole back of his
        neck. Sitting behind him in class, Andrew once counted eighty-six of them, and
        that was just a start! If Andrew had freckles like Nicky, his mother would never
        know if his neck was dirty.
      </p>},
  photo_url: 'jui.jpg',
  author_name: 'Judy Blume',
  publisher_name: 'Yearling',
  published_date: Date.parse('1978-07-15'),
  unit_price: 4.08)

book8 = Book.create(title: 'The Lowland',
  description: 
    %{<p>
        From the Pulitzer Prize-winning, best-selling author of The Namesake comes an
        extraordinary new novel, set in both India and America, that expands the scope and
        range of one of our most dazzling storytellers: a tale of two brothers bound by
        tragedy, a fiercely brilliant woman haunted by her past, a country torn by revolution,
        and a love that lasts long past death.
      </p>},
  photo_url: 'low.jpg',
  author_name: 'Jhumpa Lahiri', 
  publisher_name: 'Knopf',
  published_date: Date.parse('2013-09-24'),
  unit_price: 16.76)

book9 = Book.create(title: 'The Circle',
  description: 
    %{<p>
        When Mae Holland is hired to work for the Circle, the world's most powerful internet
        company, she feels she's been given the opportunity of a lifetime. The Circle, run out
        of a sprawling California campus, links users' personal emails, social media, banking,
        and purchasing with their universal operating system, resulting in one online identity
        and a new age of civility and transparency
      </p>},
  photo_url: 'cir.jpg',
  author_name: 'Dave Eggers', 
  publisher_name: 'Knopf',
  published_date: Date.parse('2013-10-08'),
  unit_price: 16.45)

book10 = Book.create(title: 'Bleeding Edge',
  description: 
    %{<p>
        It is 2001 in New York City, in the lull between the collapse of the dot-com boom and
        the terrible events of September 11th. Silicon Alley is a ghost town, Web 1.0 is having
        adolescent angst, Google has yet to IPO, Microsoft is still considered the Evil Empire.
      </p>},
  photo_url: 'edge.jpg',
  author_name: 'Thomas Pynchon', 
  publisher_name: 'Penguin Press HC',
  published_date: Date.parse('2013-09-17'),
  unit_price: 16.77)

book11 = Book.create(title: 'Against the Day',
  description: 
    %{<p>
        The inimitable Thomas Pynchon has done it again. Hailed as "a major work of art" by The
        Wall Street Journal, his first novel in almost ten years spans the era between the Chicago
        World's Fair of 1893 and the years just after World War I and moves among locations across
        the globe (and to a few places not strictly speaking on the map at all)
      </p>},
  photo_url: 'day.jpg',
  author_name: 'Thomas Pynchon', 
  publisher_name: 'Penguin Books',
  published_date: Date.parse('2007-10-30'),
  unit_price: 12.79)

book12 = Book.create(title: 'Creepy Carrots!',
  description: 
    %{<p>
        In this Caldecott Honor-winning picture book, The Twilight Zone comes to the carrot patch
        as a rabbit fears his favorite treats are out to get him.
      </p>},
  photo_url: 'carrot.jpg',
  author_name: 'Aaron Reynolds', 
  publisher_name: 'Simon & Schuster Books for Young Readers',
  published_date: Date.parse('2012-8-21'),
  unit_price: 12.78)

book13 = Book.create(title: 'First to Kill',
  description: 
    %{<p>
        Ten years ago, a botched mission in Nicaragua ended covert ops specialist Nathan McBride's
        CIA career. Now he utilizes his unique skill set in the private sector-until the night
        Frank Ortega, former director of the FBI, calls in a favor. A deep-cover federal agent
        has vanished, along with a ton of Semtex explosives, and Ortega needs them found-fast.
      </p>},
  photo_url: 'kill.jpg',
  author_name: 'Andrew Peterson', 
  publisher_name: 'Thomas & Mercer',
  published_date: Date.parse('2012-11-06'),
  unit_price: 7.48)

book14 = Book.create(title: 'Extra Yarn',
  description: 
    %{<p>
       Extra Yarn, a Caldecott Honor Book, Boston Globe-Horn Book Award winner, and a New York Times
       bestseller, is the story of how a young girl and her box of magical yarn transform a community.
      </p>},
  photo_url: 'yarn.jpg',
  author_name: 'Mac Barnett', 
  publisher_name: 'Balzer + Bray',
  published_date: Date.parse('2012-1-17'),
  unit_price: 12.18)

book15 = Book.create(title: 'Blackout',
  description: 
    %{<p>
        One hot summer night in the city, all the power goes out. The TV shuts off and a boy wails,
        "Mommm!" His sister can no longer use the phone, Mom can't work on her computer, and Dad can't
        finish cooking dinner. What's a family to do? When they go up to the roof to escape the heat,
        they find the lights--in stars that can be seen for a change--and so many neighbors it's like
        a block party in the sky!
      </p>},
  photo_url: 'black.jpg',
  author_name: 'John Rocco', 
  publisher_name: 'Disney-Hyperion',
  published_date: Date.parse('2011-05-24'),
  unit_price: 12.18)

Category.delete_all
cat1 = Category.create(name: "Romance",
  sort_order: 2)
cat2 = Category.create(name: "Horror",
  sort_order: 1)
cat3 = Category.create(name: "History",
  sort_order: 3)
cat4 = Category.create(name: "Travel",
  sort_order: 5)
cat5 = Category.create(name: "Adventure",
  sort_order: 4)
cat6 = Category.create(name: "Law",
  sort_order: 4)

CategoryItem.delete_all
CategoryItem.create(category_id: cat1.id,
  book_id: book1.id)
CategoryItem.create(category_id: cat2.id,
  book_id: book2.id)
CategoryItem.create(category_id: cat3.id,
  book_id: book3.id)
CategoryItem.create(category_id: cat4.id,
  book_id: book4.id)
CategoryItem.create(category_id: cat5.id,
  book_id: book5.id)
CategoryItem.create(category_id: cat6.id,
  book_id: book6.id)
CategoryItem.create(category_id: cat1.id,
  book_id: book7.id)
CategoryItem.create(category_id: cat2.id,
  book_id: book8.id)
CategoryItem.create(category_id: cat3.id,
  book_id: book9.id)
CategoryItem.create(category_id: cat4.id,
  book_id: book10.id)
CategoryItem.create(category_id: cat5.id,
  book_id: book11.id)
CategoryItem.create(category_id: cat6.id,
  book_id: book12.id)
CategoryItem.create(category_id: cat1.id,
  book_id: book13.id)
CategoryItem.create(category_id: cat2.id,
  book_id: book14.id)
CategoryItem.create(category_id: cat3.id,
  book_id: book15.id)
CategoryItem.create(category_id: cat4.id,
  book_id: book1.id)
CategoryItem.create(category_id: cat5.id,
  book_id: book2.id)
CategoryItem.create(category_id: cat6.id,
  book_id: book3.id)
CategoryItem.create(category_id: cat1.id,
  book_id: book4.id)
CategoryItem.create(category_id: cat2.id,
  book_id: book5.id)
CategoryItem.create(category_id: cat3.id,
  book_id: book6.id)
CategoryItem.create(category_id: cat4.id,
  book_id: book7.id)
CategoryItem.create(category_id: cat5.id,
  book_id: book8.id)
CategoryItem.create(category_id: cat6.id,
  book_id: book9.id)
CategoryItem.create(category_id: cat1.id,
  book_id: book10.id)
CategoryItem.create(category_id: cat2.id,
  book_id: book11.id)
CategoryItem.create(category_id: cat3.id,
  book_id: book12.id)
CategoryItem.create(category_id: cat4.id,
  book_id: book13.id)
CategoryItem.create(category_id: cat5.id,
  book_id: book14.id)
CategoryItem.create(category_id: cat6.id,
  book_id: book15.id)
CategoryItem.create(category_id: cat6.id,
  book_id: book5.id)
CategoryItem.create(category_id: cat6.id,
  book_id: book4.id)
CategoryItem.create(category_id: cat6.id,
  book_id: book1.id)
CategoryItem.create(category_id: cat6.id,
  book_id: book2.id)
CategoryItem.create(category_id: cat6.id,
  book_id: book7.id)
CategoryItem.create(category_id: cat6.id,
  book_id: book11.id)
CategoryItem.create(category_id: cat6.id,
  book_id: book13.id)
CategoryItem.create(category_id: cat6.id,
  book_id: book14.id)