require 'rails_helper'

RSpec.describe Api::V1::QuotesController, type: :request do
  let(:quote) { create(:quote) }
  let(:api_v_headers) { api_valid_headers }
  let(:api_v_newsletter_headers) { api_valid_newsletter_headers }
  let(:api_inv_newsletter_headers) { api_invalid_newsletter_headers }

  describe 'GET #index' do
    before(:each) do
      3.times { create(:quote) }
      get api_quotes_path, params: {}, headers: api_v_headers
    end

    it "returns 3 quotes" do
      expect(json['data'].length).to eq 3
    end

    it "returns success loaded message" do
      expect(json['message']).to eq Message.all_quotes_loaded
    end

    it_behaves_like "returns 200 success status"
  end

  describe 'GET #show' do
    before(:each) do
      get api_quote_path(quote.id), params: {}, headers: api_v_headers
    end

    it "returns the requested id of the quote" do
      expect(json['data']['id']).to eq quote.id
    end

    it "returns success loaded message" do
      expect(json['message']).to eq Message.quote_loaded(quote.id)
    end

    it "returns the requested title of the quote" do
      expect(json['data']['title']).to eq quote.title
    end

    it_behaves_like "returns 200 success status"
  end

  describe 'POST #newsletter_subscribe' do
    context "when request is valid and email is added" do
      before(:each) do
        newsletter_v_info = {
          "quote": {
            "firstName": "ABCDE",
            "email": "a@b.com"
          }
        }
        post api_newsletter_subscribe_path, params: newsletter_v_info.to_json, headers: api_v_newsletter_headers
      end

      it "returns success subscribed message" do
        expect(json['data']['message']).to eq Message.newsletter_email_subscribed
      end

      it_behaves_like "returns 200 success status"
    end

    context "when request is invalid" do
      context "when email is incorrect" do
        before(:each) do
          newsletter_inv_info = {
            "quote": {
              "firstName": "ABCDE",
              "email": "a@"
            }
          }
          post api_newsletter_subscribe_path, params: newsletter_inv_info.to_json, headers: api_v_newsletter_headers
        end
  
        it "returns invalid subscriber info error message" do
          expect(json['errors']['message']).to eq Message.newsletter_invalid_subscriber_info
        end
  
        it_behaves_like "returns 422 unprocessable entity status"
      end

      context "when firstName is incorrect" do
        before(:each) do
          newsletter_inv_info = {
            "quote": {
              "firstName": "A",
              "email": "a@b.com"
            }
          }
          post api_newsletter_subscribe_path, params: newsletter_inv_info.to_json, headers: api_v_newsletter_headers
        end
  
        it "returns invalid subscriber info error message" do
          expect(json['errors']['message']).to eq Message.newsletter_invalid_subscriber_info
        end
  
        it_behaves_like "returns 422 unprocessable entity status"
      end

      context "when empty/nil request is made" do
        before(:each) do
          newsletter_inv_info = {
            "quote": {
              "firstName": "",
              "email": ""
            }
          }
          post api_newsletter_subscribe_path, params: newsletter_inv_info.to_json, headers: api_v_newsletter_headers
        end
  
        it "returns invalid subscriber info error message" do
          expect(json['errors']['message']).to eq Message.newsletter_invalid_subscriber_info
        end
  
        it_behaves_like "returns 422 unprocessable entity status"
      end

      context "when improper request origin header" do
        before(:each) do
          newsletter_v_info = {
            "quote": {
              "firstName": "ABCDE",
              "email": "a@b.com"
            }
          }
          post api_newsletter_subscribe_path, params: newsletter_v_info.to_json, headers: api_inv_newsletter_headers
        end
  
        it "returns not permitted error message" do
          expect(json['errors']['message']).to eq Message.newsletter_unauthorized_request
        end
  
        it_behaves_like "returns 401 unauthorized status"
      end
    end
  end
end
