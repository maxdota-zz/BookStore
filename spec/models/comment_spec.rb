require 'spec_helper'

describe Comment do
  let(:comment) { FactoryGirl.create(:comment) }
  describe "Validations" do    
    it {should validate_presence_of :content}
  end
  
   it "is invalid with the content more than 500 characters" do
    comment.content = "Invalid content. Invalid content. Invalid content. Invalid content. Invalid content. \
    Invalid content. Invalid content. Invalid content. Invalid content. Invalid content. Invalid content. \
    Invalid content. Invalid content. Invalid content. Invalid content. Invalid content. Invalid content. \
    Invalid content. Invalid content. Invalid content. Invalid content. Invalid content. Invalid content. \
    Invalid content. Invalid content. Invalid content. Invalid content. Invalid content. Invalid content. \
    Invalid content. Invalid content. Invalid content. "
    comment.should_not be_valid
  end
end