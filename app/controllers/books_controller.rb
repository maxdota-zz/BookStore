class BooksController < ApplicationController
  skip_before_filter :admin_authorize, :user_authorize, :only => [:show]
  
  # GET /books
  # GET /books.json
  def index
    @books = Book.paginate page: params[:page], per_page: 10

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @books }
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @book = Book.find(params[:id])
    @average_rating = @book.total_rating_count == 0 ? 0 : @book.total_rating_value / @book.total_rating_count
    @rating = @average_rating.round
    if session[:user_id]
      @comment = Comment.new
      session[:book_id] = @book.id
    end
    @comments = @book.comments.order(:date).paginate page: params[:page], per_page: 5

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @books }
    end
  end

  # GET /books/new
  # GET /books/new.json
  def new
    @book = Book.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @books }
    end
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(params[:book])

    respond_to do |format|
      if @book.save
        format.html { redirect_to books_url, :notice => "Book was successfully created." }
        format.json { render :json => @book, :status => :created, :location => @book }
      else
        format.html { render :action => "new" }
        format.json { render :json => @books.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /books/1
  # PUT /books/1.json
  def update
    @book = Book.find(params[:id])

    respond_to do |format|
      if @book.update_attributes(params[:book])
        format.html { redirect_to @book, :notice => "Book was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @books.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    respond_to do |format|
      if @book.errors.any?
        format.html { redirect_to books_url, :notice => @book.errors.full_messages[0] }
      else
        format.html { redirect_to books_url, :notice => "Book was removed successfully." }
      end
    end
  end
end
