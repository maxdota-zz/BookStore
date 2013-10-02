class Book < ActiveRecord::Base
  attr_accessible :author_name, :description, :photo_url, :published_date, :publisher_name, :title, :total_rating_count, :total_rating_value, :unit_price
end
