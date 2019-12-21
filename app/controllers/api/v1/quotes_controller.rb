class Api::V1::QuotesController < ApplicationController
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
end
