class Api::V1::QuotesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:newsletter_subscribe]

  def index
    @quotes = Quote.all
    send_response = {
      status: 200,
      message: Message.all_quotes_loaded,
      data: @quotes
    }
    json_response(send_response)
  end

  def show
    @quote_id = params[:id]
    @quote = Quote.find(@quote_id)
    send_response = {
      status: 200,
      message: Message.quote_loaded(@quote_id),
      data: @quote
    }
    json_response(send_response)
  end

  def newsletter_subscribe
    if(request.origin != "https://drabkirn.cdadityang.xyz")
      send_response = {
        status: 401,
        errors: {
          message: Message.newsletter_unauthorized_request
        }
      }
      json_response(send_response, :unauthorized)
      return
    end

    require 'uri'
    require 'net/http'
    require 'json'

    subscriber_first_name = subscriber_params["firstName"]
    subscriber_email = subscriber_params["email"]

    if !(subscriber_validation(subscriber_first_name, subscriber_email))
      send_response = {
        status: 422,
        errors: {
          message: Message.newsletter_invalid_subscriber_info
        }
      }
      json_response(send_response, :unprocessable_entity)
      return
    end

    # Get temporary Access token valid for 1 hour
    uri = URI("https://api.sendpulse.com/oauth/access_token")
    request = Net::HTTP::Post.new(uri.request_uri)

    request['Content-Type'] = 'application/json'

    myBody = {
      grant_type: "client_credentials",
      client_id: ENV["newsletter_client_id"],
      client_secret: ENV["newsletter_client_secret"]
    }.to_json

    request.body = myBody

    response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
        http.request(request)
    end

    response_code = JSON.parse(response.code)
    response_body = JSON.parse(response.body)

    temp_access_token = ""

    # If access token is valid, then only continue
    if(response_code == 200)
      temp_access_token = response_body["access_token"]
    else
      send_response = {
        status: 422,
        errors: {
          message: Message.newsletter_api_error,
          detail: response_body["message"]
        }
      }
      json_response(send_response, :unprocessable_entity)
      return
    end

    # Make API call to add email to newsletter
    uri = URI("https://api.sendpulse.com/addressbooks/" + ENV["newsletter_list_id"] + "/emails")
    request = Net::HTTP::Post.new(uri.request_uri)
    
    request['Content-Type'] = 'application/json'
    request['Authorization'] = "Bearer #{temp_access_token}"

    myBody = {
      emails: [
        {
          "email": subscriber_email,
          "variables": {
            "FirstName": subscriber_first_name
          }
        }
      ]
    }.to_json

    request.body = myBody

    response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
        http.request(request)
    end

    response_code = JSON.parse(response.code)
    response_body = JSON.parse(response.body)

    if (response_code == 200)
      send_response = {
        status: 200,
        message: "Email Successfully Added in Newsletter",
        data: {
          message: Message.newsletter_email_subscribed
        }
      }
      json_response(send_response)
      return
    else
      send_response = {
        status: 422,
        errors: {
          message: Message.newsletter_api_error,
          detail: response_body["message"]
        }
      }
      json_response(send_response, :unprocessable_entity)
      return
    end
  end

  private

  def subscriber_params
    params.require(:quote).permit(:firstName, :email)
  end

  def subscriber_validation(firstName, email)
    email_regex = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    if !(firstName && email)
      return false
    elsif (firstName.length < 4 || firstName.length > 20)
      return false
    elsif !(email.match(email_regex))
      return false
    end
    return true
  end
end
