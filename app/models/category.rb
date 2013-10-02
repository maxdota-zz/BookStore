class Category < ActiveRecord::Base
  attr_accessible :name, :sort_order
  
  validates :name, uniqueness: true
end
