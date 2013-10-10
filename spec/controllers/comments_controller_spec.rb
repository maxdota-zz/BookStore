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
    it "shoud not allow same user to comment same book twice" do   
      post :create, :comment => FactoryGirl.attributes_for(:comment)
      expect {      
        post :create, :comment => FactoryGirl.attributes_for(:comment)
      }.to change { Comment.count }.by(0)
      response.should redirect_to book
      expect(flash[:notice]).to have_content("You cannot comment and rate a book twice.")      
    end
  end
  
  context "Delete comment" do
    it "should not allow normal user to delete comment" do
      session[:role] = "normal"
      comment
      expect {      
        delete :destroy, :id => comment.id
      }.to change { Comment.count }.by(0)
      response.should redirect_to store_url
    end
    it "should delete comment" do
      session[:role] = "admin"    
      post :create, :comment => FactoryGirl.attributes_for(:comment)
      comment2 = Comment.first
      expect {      
        delete :destroy, :id => comment2.id
      }.to change { Comment.count }.by(-1)
      response.should redirect_to book
    end
  end
end