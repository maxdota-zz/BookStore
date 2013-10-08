class Category < ActiveRecord::Base
  attr_accessible :name, :sort_order
  
  validates :name, :uniqueness => true
  validates :name, :presence => true
  
  has_many :category_items, :dependent => :destroy
  has_many :books, through: :category_items
  
  before_create :set_sort_order
  
  default_scope order('sort_order')
  
  def add_book(book_id)
    item = category_items.build(:book_id => book_id)
    item
  end
  
  def self.sort_order_change(category_id, direction)
    category = Category.find(category_id)
    if direction == "up"
      if category.sort_order == 1
        "Category is already the first."
      else
        other_category = Category.find_by_sort_order(category.sort_order - 1)
        category.update_attribute("sort_order", category.sort_order - 1)  
        if !other_category.nil?
          other_category.update_attribute("sort_order", category.sort_order + 1)
        end
        "Sort order of #{category.name} is up by 1."
      end  
    else
      if category.sort_order == Category.maximum(:sort_order)
        "Category is already the last."
      else
        other_category = Category.find_by_sort_order(category.sort_order + 1)
        category.update_attribute("sort_order", category.sort_order + 1)  
        if !other_category.nil?
          other_category.update_attribute("sort_order", category.sort_order - 1)
        end
        "Sort order of #{category.name} is down by 1."
      end  
    end
  end
  
  private
  def set_sort_order
    self.sort_order = Category.maximum(:sort_order) ? Category.maximum(:sort_order) + 1 : 1
  end
end
