class Category < ActiveRecord::Base
  attr_accessible :name, :sort_order
  
  validates :name, uniqueness: true
  
  has_many :category_items, dependent: :destroy
  
  def add_book(book_id)
    item = category_items.build(book_id: book_id)
    item
  end
end
