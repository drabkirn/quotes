require "rails_helper"

RSpec.describe ApplicationController, type: :request do
  let(:api_v_headers) { api_valid_headers }
  let(:ui_v_headers) { ui_valid_headers }
  
  describe "check if an request is an API request or UI request" do
    context "check for API request" do
      before(:each) do
        3.times { create(:quote) }
        # test with index action of quotes
        get api_quotes_path, params: {}, headers: api_v_headers
      end

      it "returns JSON of all the 3 Quotes" do
        expect(json['data'].length).to eq 3
      end

      it "returns application/json content type in response header" do
        content_type_response_header = response.headers["Content-Type"]
        expect(content_type_response_header).to eq "application/json; charset=utf-8"
      end

      it "returns true for ApiRequest check" do
        expect(ApiRequestCheck.new.matches?(request)).to eq true
      end

      it_behaves_like "returns 200 success status"
    end

    context "check for UI request" do
      before(:each) do
        3.times { create(:quote) }
        # test with index action of quotes
        get '/quotes', params: {}, headers: ui_v_headers
      end

      it "returns text/html content type in response header" do
        content_type_response_header = response.headers["Content-Type"]
        expect(content_type_response_header).to eq "text/html; charset=utf-8"
      end

      it "returns true for UiRequest check" do
        expect(UiRequestCheck.new.matches?(request)).to eq true
      end

      it "returns 200 success status from response" do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "#accept_header_check_for_api_requests" do
    context "when there is no Accept header" do
      before(:each) do
        # test with index action of quotes
        get api_quotes_path, params: {}, headers: api_invalid_headers_with_empty_accept_header
      end

      it "returns missing accept header message" do
        expect(json['errors']['message']).to match(Message.exception_missing_accept_header)
      end

      it_behaves_like 'returns 401 unauthorized status'
    end

    context "when there is wrong Accept header" do
      before(:each) do
        # test with index action of quotes
        get api_quotes_path, params: {}, headers: api_invalid_headers_with_wrong_accept_header
      end

      it "returns wrong accept header message" do
        expect(json['errors']['message']).to match(Message.exception_wrong_accept_header)
      end

      it_behaves_like 'returns 401 unauthorized status'
    end
  end

  describe "action_not_found when making API invalid requests" do
    context "when making a invalid request - application wide" do
      before(:each) do
        get '/xyz_invalid_request', params: {}, headers: api_v_headers
      end

      it_behaves_like "returns 404 not found status"
    end

    context "when making a invalid request - on /404" do
      before(:each) do
        get '/404', params: {}, headers: api_v_headers
      end

      it_behaves_like "returns 404 not found status"
    end
  end

  describe "internal_server_error - application wide" do
    before(:each) do
      get '/500', params: {}, headers: api_valid_headers
    end

    it_behaves_like "returns 500 internal server error status"
  end
end