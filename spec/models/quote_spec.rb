require 'rails_helper'

RSpec.describe Quote, type: :model do
  let(:quote) { FactoryBot.build :quote }
  
  subject { quote }

  it "should respond to title" do
    expect(quote).to respond_to(:title)
  end
  
  it "should respond to content" do
    expect(quote).to respond_to(:content)
  end
  
  it "should respond to author" do
    expect(quote).to respond_to(:author)
  end
  
  it "should respond to tags" do
    expect(quote).to respond_to(:tags)
  end
  
  describe "is invalid" do
    it "is invalid without a title" do
      quote.title = nil
      expect(quote).to_not be_valid
    end
    
    it "is invalid if title is empty" do
      quote.title = ''
      expect(quote).to_not be_valid
    end
    
    it "is invalid if title length is < 10" do
      quote.title = 'abcdefgh'
      expect(quote).to_not be_valid
    end

    it "is invalid without a content" do
      quote.content = nil
      expect(quote).to_not be_valid
    end
    
    it "is invalid if content is empty" do
      quote.content = ''
      expect(quote).to_not be_valid
    end
    
    it "is invalid if content length is < 10" do
      quote.content = 'abcdefgh'
      expect(quote).to_not be_valid
    end
    
    it "is invalid without a author" do
      quote.author = nil
      expect(quote).to_not be_valid
    end
    
    it "is invalid if author is empty" do
      quote.author = ''
      expect(quote).to_not be_valid
    end
    
    it "is invalid without tags" do
      quote.tags = nil
      expect(quote).to_not be_valid
    end
    
    it "is invalid if tags is empty" do
      quote.tags = []
      expect(quote).to_not be_valid
    end
    
    it "is invalid if tags length is < 3" do
      quote.tags = []
      2.times { quote.tags <<  Faker::Name.name}
      expect(quote).to_not be_valid
    end
    
    it "is invalid if tags length is > 20" do
      quote.tags = []
      21.times { quote.tags <<  Faker::Name.name}
      expect(quote).to_not be_valid
    end
  end
end
