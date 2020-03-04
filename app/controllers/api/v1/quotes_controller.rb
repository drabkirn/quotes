class Api::V1::QuotesController < ApplicationController
  ## Quotes token header must be present and valid to get access to Quotes
  before_action :check_quotes_token_header, only: [:index, :show]
  before_action :validate_quotes_token_header, only: [:index, :show]

  # API: GET /quotes
  def index
    @quotes = Quote.all
    send_response = {
      status: 200,
      message: Message.all_quotes_loaded,
      data: @quotes
    }
    json_response(send_response)
  end

  # API: GET /quotes/:id
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

  private
  ## For every request made to Quotes :show, :index
  ## Check whether QuotesToken header is present or not
  def check_quotes_token_header
    quotes_token_header = request.headers['QuotesToken'] ? request.headers['QuotesToken'] : nil
    if !quotes_token_header
      send_response = {
        status: 401,
        errors: {
          message: Message.missing_quotes_token_header
        }
      }
      json_response(send_response, :unauthorized)
      return
    end
  end

  ## For every request made to Quotes :show, :index
  ## Check whether QuotesToken header is empty or is wrong
  ## then send invalid message if something is wrong.
  def validate_quotes_token_header
    quotes_token_header = request.headers['QuotesToken']
    user = User.find_by(quotes_token: quotes_token_header)
    if user
      user.quotes_api_count += 1
      user.save!
    else
      send_response = {
        status: 401,
        errors: {
          message: Message.wrong_quotes_token_header
        }
      }
      json_response(send_response, :unauthorized)
      return
    end
  end
end
