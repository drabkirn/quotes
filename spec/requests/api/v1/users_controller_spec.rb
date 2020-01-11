require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  let(:user) { create(:user) }
  let(:api_v_headers) { api_valid_headers }
  let(:api_v_user_headers) do
    {
      "Content-Type": "application/json",
      "Accept": "application/drabkirn.quotes.v1",
      "Authorization": user.auth_token
    }
  end
  let(:api_inv_user_headers) do
    {
      "Content-Type": "application/json",
      "Accept": "application/drabkirn.quotes.v1",
      "Authorization": "ABCD"
    }
  end
  let(:api_v_user_callback_headers) do
    {
      "Content-Type": "application/json",
      "Accept": "application/drabkirn.quotes.v1",
      "AppzaSecret": "testsecret"
    }
  end
  let(:api_inv_user_callback_headers) do
    {
      "Content-Type": "application/json",
      "Accept": "application/drabkirn.quotes.v1"
    }
  end
  let(:api_inv_user_callback_wrong_secret_headers) do
    {
      "Content-Type": "application/json",
      "Accept": "application/drabkirn.quotes.v1",
      "AppzaSecret": "wrongsecreta"
    }
  end

  let(:users_v_credentials) do
    {
      user: {
        id: user.id,
        username: user.username,
        auth_token: user.auth_token
      }
    }
  end
  let(:users_v_create_credentials) do
    {
      user: {
        id: 100,
        username: "abcde",
        auth_token: "abcde"
      }
    }
  end
  let(:users_inv_credentials_no_id) do
    {
      user: {
        username: user.username,
        auth_token: user.auth_token
      }
    }
  end

  describe 'GET #show' do
    context "when the request is valid" do
      before(:each) do
        get api_users_show_path, params: {}, headers: api_v_user_headers
      end
  
      it "returns success loaded message" do
        expect(json['message']).to eq Message.user_loaded(user.id)
      end
  
      it "returns the requested id of the user" do
        expect(json['data']['id']).to eq user.id
      end
  
      it "returns the requested username of the user" do
        expect(json['data']['username']).to eq user.username
      end
  
      it_behaves_like "returns 200 success status"
    end

    context "when the request is invalid" do
      context "when auth_token is missing" do
        before(:each) do
          get api_users_show_path, params: {}, headers: api_v_headers
        end
    
        it "returns missing token error message" do
          expect(json['errors']['message']).to eq Message.missing_auth_token
        end
    
        it_behaves_like "returns 401 unauthorized status"
      end

      context "when auth_token is wrong" do
        before(:each) do
          get api_users_show_path, params: {}, headers: api_inv_user_headers
        end
    
        it "returns missing token error message" do
          expect(json['errors']['message']).to eq Message.wrong_auth_token
        end
    
        it_behaves_like "returns 401 unauthorized status"
      end
    end
  end

  describe 'POST auth/callback' do
    context "when the request is valid" do
      context "when user exists - update" do
        before(:each) do
          post api_auth_callback_path, params: users_v_credentials.to_json, headers: api_v_user_callback_headers
        end
    
        it "returns success updated message" do
          expect(json['message']).to eq Message.user_database_updated
        end
    
        it "returns empty data" do
          expect(json['data']).to eq ''
        end
    
        it_behaves_like "returns 200 success status"
      end

      context "when new user - create" do
        before(:each) do
          post api_auth_callback_path, params: users_v_create_credentials.to_json, headers: api_v_user_callback_headers
        end
    
        it "returns success updated message" do
          expect(json['message']).to eq Message.user_database_updated
        end
    
        it "returns empty data" do
          expect(json['data']).to eq ''
        end
    
        it_behaves_like "returns 200 success status"
      end
    end

    context "when the request is invalid" do
      context "when user_params id is missing" do
        before(:each) do
          post api_auth_callback_path, params: users_inv_credentials_no_id.to_json, headers: api_v_user_callback_headers
        end
    
        it "returns missing token error message" do
          expect(json['errors']['message']).to eq Message.users_callback_missing_params
        end
    
        it_behaves_like "returns 422 unprocessable entity status"
      end

      context "when there is no AppzaSecret" do
        before(:each) do
          post api_auth_callback_path, params: users_v_credentials.to_json, headers: api_inv_user_callback_headers
        end
    
        it "returns missing token error message" do
          expect(json['errors']['message']).to eq Message.mising_appza_secret_header
        end
    
        it_behaves_like "returns 401 unauthorized status"
      end

      context "when wrong AppzaSecret is mentioned" do
        before(:each) do
          post api_auth_callback_path, params: users_v_credentials.to_json, headers: api_inv_user_callback_wrong_secret_headers
        end
    
        it "returns missing token error message" do
          expect(json['errors']['message']).to eq Message.wrong_appza_secret_header
        end
    
        it_behaves_like "returns 401 unauthorized status"
      end
    end
  end

  describe 'GET auth/login - #authenticate' do
    context "when the request is valid" do
      before(:each) do
        get "/auth/login?auth_token=#{user.auth_token}", params: {}, headers: ui_valid_headers
      end

      it "redirects to dash with auth_token" do
        expect(response).to redirect_to("/dash?auth_token=#{user.auth_token}")
      end

      it "returns 302 redirect status" do
        expect(response).to have_http_status "302"
      end
    end

    context "when the request is invalid" do
      context "when there is no auth_token in request" do
        before(:each) do
          get "/auth/login", params: {}, headers: ui_valid_headers
        end
  
        it "returns missing token error message" do
          expect(json['errors']['message']).to eq Message.missing_auth_token
        end
    
        it_behaves_like "returns 401 unauthorized status"
      end

      context "when wrong auth_token is present in request" do
        before(:each) do
          get "/auth/login?auth_token=abc", params: {}, headers: ui_valid_headers
        end
  
        it "returns missing token error message" do
          expect(json['errors']['message']).to eq Message.wrong_auth_token
        end
    
        it_behaves_like "returns 401 unauthorized status"
      end
    end
  end
end
