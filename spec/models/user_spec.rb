require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(user).to be_valid
    end

    context "quotes_token validations" do
      it { should validate_presence_of(:quotes_token) }

      it "should respond to quotes_token" do
        expect(user).to respond_to(:quotes_token)
      end

      it "is invalid with a blank quotes_token" do
        user.quotes_token = " "
        user.valid?
        expect(user.errors[:quotes_token]).to include("can't be blank")
      end

      it "is invalid with no quotes_token" do
        user.quotes_token = nil
        user.valid?
        expect(user.errors[:quotes_token]).to include("can't be blank")
      end

      it "is invalid with a duplicate quotes_token" do
        user.save
        @otheruser = FactoryBot.build(:user, quotes_token: user.quotes_token)
        @otheruser.valid?
        expect(@otheruser.errors[:quotes_token]).to include("has already been taken")
      end

      it "is invalid if length is != 30" do
        user.quotes_token = "ab"
        user.valid?
        expect(user.errors[:quotes_token]).to include("is the wrong length (should be 30 characters)")
      end
    end

    context "quotes_api_count validations" do
      it { should validate_presence_of(:quotes_api_count) }

      it "should respond to quotes_api_count" do
        expect(user).to respond_to(:quotes_api_count)
      end

      it "is invalid with a blank quotes_api_count" do
        user.quotes_api_count = " "
        user.valid?
        expect(user.errors[:quotes_api_count]).to include("can't be blank")
      end

      it "is invalid with no quotes_api_count" do
        user.quotes_api_count = nil
        user.valid?
        expect(user.errors[:quotes_api_count]).to include("can't be blank")
      end
    end
  end
end
