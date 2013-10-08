class Comment < ActiveRecord::Base
  attr_accessible :book_id, :content, :date, :rating, :user_id
  
  belongs_to :book
  belongs_to :user
  
  validates :content, :presence => true
  validate :content_is_less_than_500_characters
  
  private
  def content_is_less_than_500_characters
    errors[:Comment] << "is too long (maximum is 500 characters)" if self.content.length > 500
  end
end
