class CategoriesController < ApplicationController
  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.order(:sort_order)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @categories }
    end
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @category = Category.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @category }
    end
  end

  # GET /categories/new
  # GET /categories/new.json
  def new
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @category }
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
    @category.sort_order = Category.all.max_by(&:sort_order).sort_order + 1
    puts @category.sort_order
    puts "TESTING HERE"

    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_url, notice: 'Category was successfully created.' }
        format.json { render json: @category, status: :created, location: @category }
      else
        format.html { render action: "new" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.json
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to categories_url, notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully removed.'  }
      format.json { head :no_content }
    end
  end
  
  def up
    @category = Category.find(params[:id])
    if @category.sort_order == 1
      redirect_to categories_url, notice: 'Category is already the first.'
    else
      @other_category = Category.find_by_sort_order(@category.sort_order - 1)
      @category.update_attribute("sort_order", @category.sort_order - 1)  
      if !@other_category.nil?
        @other_category.update_attribute("sort_order", @category.sort_order + 1)
      end
      redirect_to categories_url, notice: 'Sort order of ' + @category.name + ' is up by 1.'
    end  
  end
  
  def down
    @category = Category.find(params[:id])
    if @category == Category.all.max_by(&:sort_order) 
      redirect_to categories_url, notice: 'Category is already the last.'
    else
      @other_category = Category.find_by_sort_order(@category.sort_order + 1)
      @category.update_attribute("sort_order", @category.sort_order + 1)
      if !@other_category.nil?
        @other_category.update_attribute("sort_order", @category.sort_order - 1)
      end
      redirect_to categories_url, notice: 'Sort order of ' + @category.name + ' is down by 1.'
    end  
  end
  
  def book_display
    @category = Category.find(params[:id])   
    @category_books = Book.all.find_all{|book| (book.categories.include? Category.find(@category.id)) }
    @other_books = []
    Book.all.each do |book|
      if !@category_books.any?{ |b| b.id == book.id }
        @other_books << book
      end
    end  
  end
  
  def book_add
    @category = Category.find(params[:category_id])
    @book = Book.find(params[:book_id])
    @item = @category.add_book(@book.id)
    
    respond_to do |format|
      if @item.save
        format.html { redirect_to category_book_display_url(@category.id), notice: "Book added to category successfully." }
        format.json { render json: @item, status: :created, location: @item }
      else
        format.html { render action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def book_remove
    @category = Category.find(params[:category_id])
    @book = Book.find(params[:book_id])
    @item = CategoryItem.all.find_all{|item| item.category_id == @category.id }.find_all{|item| item.book_id == @book.id }.first    
    @item.destroy
    
    respond_to do |format|
      format.html { redirect_to category_book_display_url(@category.id), notice: "Book removed from category successfully." }
      format.json { render json: @item, status: :created, location: @item }
    end
  end
end
