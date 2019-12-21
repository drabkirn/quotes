require 'rails_helper'

RSpec.describe Api::V1::QuotesController, type: :request do
  let(:quote) { create(:quote) }
  let(:api_v_headers) { api_valid_headers }

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
end
