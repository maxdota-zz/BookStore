class CategoryItem < ActiveRecord::Base
  attr_accessible :book_id, :category_id
    
  belongs_to :category
  belongs_to :book
end
