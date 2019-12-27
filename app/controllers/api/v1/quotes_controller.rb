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

    uri = URI("https://us4.api.mailchimp.com/3.0/lists/" + ENV["newsletter_list_id"] + "/members")
    request = Net::HTTP::Post.new(uri.request_uri)
    # Request headers
    request['Content-Type'] = 'application/json'
    request['Authorization'] = 'auth ' + ENV["newsletter_api_key"]

    # Request body
    myBody = {
      email_address: subscriber_email,
      status: "subscribed",
      merge_fields: {
        FNAME: subscriber_first_name
      }
    }.to_json

    request.body = myBody

    response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
        http.request(request)
    end

    response_body = JSON.parse(response.body)

    if (response.code.to_i < 300)
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
          detail: response_body["detail"]
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
