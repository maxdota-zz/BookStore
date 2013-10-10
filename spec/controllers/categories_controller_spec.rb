require 'spec_helper'

describe CategoriesController do
  let!(:admin) { FactoryGirl.create(:admin) }
  let(:category) { FactoryGirl.create(:category) }
  let(:category2) { FactoryGirl.create(:category) }
  let(:category3) { FactoryGirl.create(:category) }
  
  before do
    session[:user_id] = admin.id
    session[:role] = "admin"
  end
 
  it "create new category" do   
    expect {      
      post :create, :category => FactoryGirl.attributes_for(:category)
    }.to change { Category.count }.by(1)
    expect(flash[:notice]).to have_content("Category was successfully created.")
  end  
end