class CategoryItemsController < ApplicationController
  # GET /category_items
  # GET /category_items.json
  def index
    @category_items = CategoryItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @category_items }
    end
  end

  # GET /category_items/1
  # GET /category_items/1.json
  def show
    @category_item = CategoryItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @category_item }
    end
  end

  # GET /category_items/new
  # GET /category_items/new.json
  def new
    @category_item = CategoryItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @category_item }
    end
  end

  # GET /category_items/1/edit
  def edit
    @category_item = CategoryItem.find(params[:id])
  end

  # POST /category_items
  # POST /category_items.json
  def create
    @category_item = CategoryItem.new(params[:category_item])

    respond_to do |format|
      if @category_item.save
        format.html { redirect_to @category_item, notice: 'Category item was successfully created.' }
        format.json { render json: @category_item, status: :created, location: @category_item }
      else
        format.html { render action: "new" }
        format.json { render json: @category_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /category_items/1
  # PUT /category_items/1.json
  def update
    @category_item = CategoryItem.find(params[:id])

    respond_to do |format|
      if @category_item.update_attributes(params[:category_item])
        format.html { redirect_to @category_item, notice: 'Category item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @category_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /category_items/1
  # DELETE /category_items/1.json
  def destroy
    @category_item = CategoryItem.find(params[:id])
    @category_item.destroy

    respond_to do |format|
      format.html { redirect_to category_items_url }
      format.json { head :no_content }
    end
  end
end
