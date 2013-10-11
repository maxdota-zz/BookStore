require 'spec_helper'

describe CategoriesController do
  let!(:admin) { FactoryGirl.create(:admin) }
  let(:book) { FactoryGirl.create(:book) }
  let!(:category) { FactoryGirl.create(:category) }
  let(:category2) { FactoryGirl.create(:category) }
  let(:category3) { FactoryGirl.create(:category) }
  
  before do
    session[:user_id] = admin.id
    session[:role] = "admin"
  end
 
  it "should create new category" do   
    expect {      
      post :create, :category => FactoryGirl.attributes_for(:category)
    }.to change { Category.count }.by(1)
    expect(flash[:notice]).to have_content("Category was successfully created.")
  end  
  
  it "should update category name" do
    put :update, :id => category.id, :category => { :name => "Technology" }
    category.reload
    category.name.should == "Technology"       
  end
  
  it "should delete category" do
    expect {
      delete :destroy, :id => category.id
    }.to change { Category.count }.by(-1)
    response.should redirect_to categories_url
  end
  
  describe "Manage sort order" do
    before do
      category2
      category3
    end
    context "Up sort order" do
      it "should not allow the first category to move up" do
        expect {
          get :up, :id => category.id
        }.to change { Category.find(category.id).sort_order }.by(0)
        expect(flash[:notice]).to have_content("Category is already the first.")
      end
      it "should move the category up" do
        expect {
          get :up, :id => category2.id
        }.to change { Category.find(category2.id).sort_order }.by(-1)
        expect(flash[:notice]).to have_content("Sort order of #{category2.name} is up by 1.")        
      end
      it "should move the higher category down" do
        expect {
          get :up, :id => category2.id
        }.to change { Category.find(category.id).sort_order }.by(1)      
      end
    end
    context "Down sort order" do
      it "should not allow the last category to move down" do
        expect {
          get :down, :id => category3.id
        }.to change { Category.find(category3.id).sort_order }.by(0)
        expect(flash[:notice]).to have_content("Category is already the last.")
      end
      it "should move the category down" do
        expect {
          get :down, :id => category2.id
        }.to change { Category.find(category2.id).sort_order }.by(1)
        expect(flash[:notice]).to have_content("Sort order of #{category2.name} is down by 1.")        
      end
      it "should move the lower category down" do
        expect {
          get :down, :id => category2.id
        }.to change { Category.find(category3.id).sort_order }.by(-1)      
      end
    end
  end
  
  describe "Manage book in category" do
    before do
      book
    end
    it "should add book to category" do
      expect {
        get :add_book, :book_id => book.id, :category_id => category.id
      }.to change { Category.find(category.id).books.count }.by(1)
      response.should redirect_to category_display_other_books_url(category.id)
    end
    it "should remove book from category" do
      get :add_book, :book_id => book.id, :category_id => category.id
      expect {
        get :remove_book, :book_id => book.id, :category_id => category.id
      }.to change { Category.find(category.id).books.count }.by(-1)
      response.should redirect_to category_display_books_url(category.id)
    end
  end
end