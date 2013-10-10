class Book < ActiveRecord::Base
  attr_accessible :author_name, :description, :photo_url, :published_date, :publisher_name, :title, :total_rating_count, :total_rating_value, :unit_price

  validates :author_name, :description, :photo_url, :published_date, :publisher_name, :title, :unit_price, :presence => true
  
  before_destroy :ensure_not_referenced_by_any_category_item
  before_create :set_defaults
  has_many :category_items
  has_many :categories, :through => :category_items
  has_many :comments, :dependent => :destroy
  
  def add_rate(rate)
    self.update_attribute("total_rating_count", total_rating_count + 1)
    self.update_attribute("total_rating_value", total_rating_value + rate)
  end
  
  def remove_rate(rate)
    self.update_attribute("total_rating_count", total_rating_count - 1 < 0 ? 0 : total_rating_count - 1)
    self.update_attribute("total_rating_value", total_rating_value - rate < 0 ? 0 : total_rating_value - rate)
  end
  
  def add_comment(comment, user_id, book_id)
    if !Comment.where("user_id = ? and book_id = ?", user_id, book_id).empty?
      "You cannot comment and rate a book twice."
    else
      comment.user_id = user_id
      comment.book_id = book_id
      comment.date = Date.current
      if comment.save
        add_rate(comment.rating)
        "Comment has been made successfully."
      else
        comment.errors.full_messages[0]
      end
    end
  end
  
  private
  # ensure that there are no category items referencing this book
  def ensure_not_referenced_by_any_category_item
    if category_items.empty?
      return true
    else
      errors.add(:base, "Please remove the book from category first.")
      return false
    end
  end
  
  def set_defaults
    self.total_rating_value = 0
    self.total_rating_count = 0
  end
end
