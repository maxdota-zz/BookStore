class Book < ActiveRecord::Base
  attr_accessible :author_name, :description, :photo_url, :published_date, :publisher_name, :title, :total_rating_count, :total_rating_value, :unit_price

  validates :author_name, :description, :photo_url, :published_date, :publisher_name, :title, presence: true
  before_destroy :ensure_not_referenced_by_any_category_item
  has_many :category_items
  has_many :categories, through: :category_items
  
  
    # ensure that there are no category items referencing this book
    def ensure_not_referenced_by_any_category_item
      if category_items.empty?
        return true
      else
        errors.add(:base, 'Please remove the book from category first.')
        return false
      end
    end
end
