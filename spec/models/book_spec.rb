require 'spec_helper'

describe Book do

  describe "Validations" do    
    it {should validate_presence_of :title}
    it {should validate_presence_of :author_name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :photo_url}
    it {should validate_presence_of :published_date}
    it {should validate_presence_of :publisher_name}
    it {should validate_presence_of :unit_price}
  end
end