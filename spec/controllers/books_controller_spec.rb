require 'spec_helper'

describe BooksController do
  let!(:admin) { FactoryGirl.create(:admin) }
  let(:book) { FactoryGirl.create(:book) }
  let(:book2) { FactoryGirl.create(:book) }
  let(:category) { FactoryGirl.create(:category) }
  let(:comment) { FactoryGirl.create(:comment)}
  
  before do
    session[:user_id] = admin.id
    session[:role] = "admin"
  end
  
  context "Create book" do
    it "should not allow anonymous user to add book" do
      session[:user_id] = nil
      expect {      
        post :create, :book => FactoryGirl.attributes_for(:book)
      }.to change { Book.count }.by(0)
      response.should redirect_to login_url
    end
    it "should not allow normal user to add book" do
      session[:role] = "normal"
      expect {      
        post :create, :book => FactoryGirl.attributes_for(:book)
      }.to change { Book.count }.by(0)
      response.should redirect_to store_url
    end
    it "should add the book" do
      expect {      
        post :create, :book => FactoryGirl.attributes_for(:book)
      }.to change { Book.count }.by(1)
      response.should redirect_to books_url
    end
  end
  
  context "Edit book" do
    it "should update new title/description/photo url" do      
      put :update, :id => book.id, :book => { :title => "New Title", :description => "Hello This is New", :photo_url => "new.png" }
      book.reload
      book.title.should == "New Title"  
      book.description.should == "Hello This is New"  
      book.photo_url.should == "new.png"  
    end
    it "should update new author/publisher name" do      
      put :update, :id => book.id, :book => { :author_name => "New Author", :publisher_name => "New Publisher" }
      book.reload
      book.author_name.should == "New Author"  
      book.publisher_name.should == "New Publisher"  
    end  
    it "should update new unit price/ published date" do      
      put :update, :id => book.id, :book => { :unit_price => 10, :published_date => Date.parse("2012-05-06") }
      book.reload
      book.unit_price.should == 10
      book.published_date.should == Date.parse("2012-05-06")
    end
  end
  
  context "Delete book" do
    it "should raise error if the book is in a category" do
      category.add_book(book.id).save    
      expect {
        delete :destroy, :id => book.id
      }.to change { Book.count }.by(0)
      response.should redirect_to books_url
      expect(flash[:notice]).to have_content("Please remove the book from category first.")
    end
    it "should delete book" do  
      book
      expect {
        delete :destroy, :id => book.id
      }.to change { Book.count }.by(-1)
      response.should redirect_to books_url
      expect(flash[:notice]).to have_content("Book was removed successfully.")
    end
  end
end