class Api::V1::UsersController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:callback]

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

  def show
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
      send_response = {
        status: 200,
        message: Message.user_loaded(user.id),
        data: {
          id: user.id,
          username: user.username,
          quotes_token: user.quotes_token,
          quotes_api_count: user.quotes_api_count
        }
      }
      json_response(send_response)
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

  private

  def auth_params
    params.require(:user).permit(:id, :username, :auth_token)
  end
end
