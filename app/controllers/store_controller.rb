class StoreController < ApplicationController
  def index
    @categories = Category.all
    @category = params[:category].nil? ? @categories.first : Category.find(params[:category])
    if params[:pagination] && params[:pagination].to_i <= 10 && params[:pagination].to_i > 0
      @books = @category.books.paginate page: params[:page], per_page: params[:pagination]
    else
      @books = @category.books.paginate page: params[:page], per_page: 5
    end
  end
  
  def book_search
    if params[:search_category] == "all"
      if params[:search_type] == "title"
        @books = Book.where("upper(title) like upper('%#{params[:search_input]}%')")
      else
        @books = Book.where("upper(author_name) like upper('%#{params[:search_input]}%')")
      end
    else      
      @category = Category.find(params[:search_category])
      # to display the category name in the view
      @categories = [@category]
      if params[:search_type] == "title"        
        @books = Book.where("upper(title) like upper('%#{params[:search_input]}%') and id in (?)", @category.books)
      else  
        @books = Book.where("upper(author_name) like upper('%#{params[:search_input]}%') and id in (?)", @category.books)
      end
    end
    if @books
      @books = @books.paginate page: params[:page], per_page: 5
      current_search = @books
    end
  end
end
