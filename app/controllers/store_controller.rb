class StoreController < ApplicationController
  def index
    @categories = Category.order(:sort_order)
    if params[:category]
      @category_id = params[:category]
    else
      @category_id = @categories[0].id.to_s
    end
    
    @books = Book.all.find_all{|book| (book.categories.include? Category.find(@category_id)) }
  end
  
  def book_search
    if params[:search_category] == "all"
      if params[:search_type] == "title"
        @books = Book.all.find_all{|book| !(book.title =~ /#{params[:search_input]}/).nil? }
      else
        @books = Book.all.find_all{|book| !(book.author_name =~ /#{params[:search_input]}/).nil? }
      end
    else      
      @categories = [Category.find(params[:search_category])]
      if params[:search_type] == "title"
        @books = Book.all.find_all{|book| !(book.title =~ /#{params[:search_input]}/).nil? && (book.categories.include? Category.find(params[:search_category])) }
      else        
        @books = Book.all.find_all{|book| !(book.author_name =~ /#{params[:search_input]}/).nil? && (book.categories.include? Category.find(params[:search_category])) }
      end
    end
  end
end
