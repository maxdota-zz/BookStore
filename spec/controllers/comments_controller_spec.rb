require 'spec_helper'

describe CommentsController do
  let(:comment) { FactoryGirl.create(:comment) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:book) { FactoryGirl.create(:book) }
  
  before do
    session[:user_id] = admin.id
    session[:book_id] = book.id
  end
  context "Add comment" do
    it "shoud not allow anonymous user to comment" do      
      session[:user_id] = nil
      expect {      
        post :create, :comment => FactoryGirl.attributes_for(:comment)
      }.to change { Comment.count }.by(0)
      response.should redirect_to login_url
    end
    it "shoud create comment" do   
      expect {      
        post :create, :comment => FactoryGirl.attributes_for(:comment)
      }.to change { Comment.count }.by(1)
      response.should redirect_to book
    end
    it "should increase rating count of the book" do
      expect {      
        post :create, :comment => FactoryGirl.attributes_for(:comment)
      }.to change { Book.find(book.id).total_rating_count }.by(1)
    end
    it "should increase rating value of the book" do
      expect {      
        post :create, :comment => FactoryGirl.attributes_for(:comment, :rating => 3)
      }.to change { Book.find(book.id).total_rating_value }.by(3)
    end
    it "shoud not allow same user to comment same book twice" do   
      post :create, :comment => FactoryGirl.attributes_for(:comment)
      expect {      
        post :create, :comment => FactoryGirl.attributes_for(:comment)
      }.to change { Comment.count }.by(0)
      response.should redirect_to book
      expect(flash[:notice]).to have_content("You cannot comment and rate a book twice.")      
    end
  end
  
   describe "Delete comment" do
    it "should not allow normal user to delete comment" do
      session[:role] = "normal"
      comment
      expect {      
        delete :destroy, :id => comment.id
      }.to change { Comment.count }.by(0)
      response.should redirect_to store_url
    end
    context "Delete comment" do
      before do        
        session[:role] = "admin"   
        post :create, :comment => FactoryGirl.attributes_for(:comment)
      end
      it "should destroy comment" do
        expect {      
          delete :destroy, :id => Comment.first.id
        }.to change { Comment.count }.by(-1)
        response.should redirect_to book       
      end
      it "should decrease rating count of the book" do
        expect {      
          delete :destroy, :id => Comment.first.id
        }.to change { Book.find(book.id).total_rating_count }.by(-1)
      end
      it "should decrease rating value of the book" do
        c = Comment.first
        expect {      
          delete :destroy, :id => c.id
        }.to change { Book.find(book.id).total_rating_value }.by(-c.rating)
      end
    end
  end
end