class CategoriesController < ApplicationController
  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.order(:sort_order)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @categories }
    end
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @category = Category.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @category }
    end
  end

  # GET /categories/new
  # GET /categories/new.json
  def new
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @category }
    end
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_url, :notice => "Category was successfully created." }
        format.json { render :json => @category, :status => :created, :location => @category }
      else
        format.html { render :action => "new" }
        format.json { render :json => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.json
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to categories_url, :notice => "Category was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url, :notice => "Category was successfully removed." }
      format.json { head :no_content }
    end
  end
  
  def up
    result = Category.sort_order_change(params[:id], "up")
    redirect_to categories_url, notice: result
  end
  
  def down
    result = Category.sort_order_change(params[:id], "down")
    redirect_to categories_url, :notice => result
  end
  
  def display_books
    @category = Category.find(params[:id])
    @books = @category.books.paginate page: params[:page], per_page: 6
  end
  
  def display_other_books
    @category = Category.find(params[:id])
    if @category.books.empty?
      @other_books = Book.paginate page: params[:page], per_page: 6
    else
      @other_books = Book.where('id not in (?)', @category.books).paginate page: params[:page], per_page: 6
    end
  end
  
  def add_book
    category = Category.find(params[:category_id])
    book = Book.find(params[:book_id])
    item = category.add_book(book.id)
    
    respond_to do |format|
      if item.save
        format.html { redirect_to category_display_other_books_url(category.id), :notice => "Book added to category successfully." }
        format.json { render :json => item, :status => :created, :location => item }
      else
        format.html { render action: "new" }
        format.json { render :json => item.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def remove_book
    category = Category.find(params[:category_id])
    book = Book.find(params[:book_id])
    CategoryItem.where('category_id = (?) and book_id = (?)', category.id, book.id).first.destroy 
    
    respond_to do |format|
      format.html { redirect_to category_display_books_url(category.id), :notice => "Book removed from category successfully." }
      format.json { render :json => item, :status => :created, :location => item }
    end
  end
end
