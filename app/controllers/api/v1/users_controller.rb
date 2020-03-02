class Api::V1::UsersController < ApplicationController
  ## When sending POST to callback, don't check for authenticity token
  ## We do this because POST req is sent here from browser
  skip_before_action :verify_authenticity_token, only: [:callback]

  ## User is required to perform this action
  before_action :require_user, only: [:show, :destroy]

  ## If user sends Authorization token, we can refer to that as current_user
  attr_reader :current_user

  # API: POST /auth/callback
  ## Must have user_id, username, auth_token in params
  ## Must have AppzaSecret in header to validate current Appza account.
  ## If AppzaSecret is wrong, that means user came to wrong app with it's credentials.
  ## If all above conditions are met, create user if not already created
  ## If already created, update it's username and auth_token
  def callback
    user_params = auth_params.to_h
    appza_secret = request.headers["AppzaSecret"]
    if(!user_params["id"] || !user_params["username"] || !user_params["auth_token"])
      send_response = {
        status: 422,
        errors: {
          message: Message.users_callback_missing_params
        }
      }
      json_response(send_response, :unprocessable_entity)
      return
    end

    if(!appza_secret)
      send_response = {
        status: 401,
        errors: {
          message: Message.mising_appza_secret_header
        }
      }
      json_response(send_response, :unauthorized)
      return
    end

    if(appza_secret != ENV["appza_secret"])
      send_response = {
        status: 401,
        errors: {
          message: Message.wrong_appza_secret_header
        }
      }
      json_response(send_response, :unauthorized)
      return
    end

    user = User.where(id: user_params["id"]).first
    if user
      user.username = user_params["username"]
      user.auth_token = user_params["auth_token"]
      user.save!
    else
      user = User.create!(id: user_params["id"], username: user_params["username"], auth_token: user_params["auth_token"])
    end
    send_response = {
      status: 200,
      message: Message.user_database_updated,
      data: ""
    }
    json_response(send_response)
  end

  # API: GET /auth/login
  ## Must have auth_token to move forward
  ## If auth_token is present, check against DB for it
  ## If correct, move forward. If wrong, go back and login again.
  def authenticate
    auth_token = params["auth_token"]
    if !auth_token
      send_response = {
        status: 401,
        errors: {
          message: Message.missing_auth_token
        }
      }
      json_response(send_response, :unauthorized)
      return
    end

    user = User.find_by(auth_token: auth_token)
    if user
      redirect_to "/dash?auth_token=" + auth_token
    else
      send_response = {
        status: 401,
        errors: {
          message: Message.wrong_auth_token
        }
      }
      json_response(send_response, :unauthorized)
    end
  end

  # API: GET /users/show
  ## Must include Authorization token to ensure user is logged in, then show user info
  def show
    send_response = {
      status: 200,
      message: Message.user_loaded(@current_user.id),
      data: {
        id: @current_user.id,
        username: @current_user.username,
        quotes_token: @current_user.quotes_token,
        quotes_api_count: @current_user.quotes_api_count
      }
    }
    json_response(send_response)
  end

  # API: DELETE /users/destroy
  ## Must include Authorization token to ensure user is logged in, then delete
  def destroy
    @current_user.destroy
    send_response = {
      status: 200,
      message: Message.user_destroyed(@current_user.id),
      data: {}
    }
    json_response(send_response)
  end

  private

  ## Allow id, username and auth_token params to callback API
  ## This is required for whitelisting
  def auth_params
    params.require(:user).permit(:id, :username, :auth_token)
  end

  ## User is required to perform this action
  ## So we check for Authorization header
  ## then find the user, and assign it to @current_user
  ## Now, @current_user can be used anywhere in that action
  def require_user
    auth_token = request.headers['Authorization'] ? request.headers['Authorization'].split(' ').last : nil
    if !auth_token
      send_response = {
        status: 401,
        errors: {
          message: Message.missing_auth_token
        }
      }
      json_response(send_response, :unauthorized)
      return
    end

    user = User.find_by(auth_token: auth_token)

    if user
      @current_user = user
    else
      send_response = {
        status: 401,
        errors: {
          message: Message.wrong_auth_token
        }
      }
      json_response(send_response, :unauthorized)
      return
    end
  end
end
