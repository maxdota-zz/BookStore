class StoreController < ApplicationController
  skip_before_filter :user_authorize, :admin_authorize
  def index
    if params[:pagination] && params[:pagination].to_i <= 10 && params[:pagination].to_i > 0
      session[:pagination] = params[:pagination]
    end
    session[:pagination] ||= 5
    @categories = Category.all
    if !@categories.empty?
      @category = params[:category].nil? ? @categories.first : Category.find(params[:category])
      @books = @category.books.order(:title).paginate page: params[:page], per_page: session[:pagination]
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
      if params[:pagination] && params[:pagination].to_i <= 10 && params[:pagination].to_i > 0
        session[:pagination] = params[:pagination]
      end
      session[:pagination] ||= 5
      @books = @books.order(:title).paginate page: params[:page], per_page: session[:pagination]
      current_search = @books
    end
  end
  
  def change_pagination
    session[:pagination] = params[:number]
    respond_to do |format|
      format.js   {}
    end
  end
end
