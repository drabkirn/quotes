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
    permitted_origins = ["http://192.168.225.128:3004", "https://drabkirn.cdadityang.xyz"]
    if(!permitted_origins.include?(request.origin))
      send_response = {
        status: 401,
        errors: {
          message: Message.newsletter_unauthorized_request
        }
      }
      json_response(send_response, :unauthorized)
      return
    end

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

    emails_txt_file = File.open(File.dirname(Dir.pwd) + '/quotes/db/emails.txt', 'a');
    emails_txt_file.puts "#{subscriber_email},#{subscriber_first_name}\n"
    emails_txt_file.close

    send_response = {
      status: 200,
      message: "Email Successfully Added in Newsletter",
      data: {
        message: Message.newsletter_email_subscribed
      }
    }
    json_response(send_response)
    return
  end

  private

  def subscriber_params
    params.require(:quote).permit(:firstName, :email)
  end

  def subscriber_validation(firstName, email)
    email_regex = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    if(firstName.nil? || firstName.empty? || email.nil? || email.empty? )
      return false
    elsif (firstName.length < 4 || firstName.length > 20)
      return false
    elsif !(email.match(email_regex))
      return false
    end
    return true
  end
end
