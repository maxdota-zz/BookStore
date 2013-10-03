class StoreController < ApplicationController
  def index
    @categories = Category.order(:sort_order)
    if params[:category]
      @category_id = params[:category]
    else
      @category_id = @categories[0].id.to_s
    end
    
    @items = CategoryItem.all.find_all{|item| item.category_id.to_s == @category_id }
    @books = []    
    @items.each do |item|
      puts "Item id: " + item.id
      @books << Book.find_by_id(item.book_id)
    end
    puts "BOOK"
    puts books
  end
end
