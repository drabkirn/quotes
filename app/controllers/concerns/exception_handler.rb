# Handling custom Exceptions that Rails app throws
module ExceptionHandler
  extend ActiveSupport::Concern
  
  # Define custom error subclasses - rescue catches `StandardErrors`
  class MissingAcceptHeader < StandardError; end
  class WrongAcceptHeader < StandardError; end
  class InternalServerError < StandardError; end

  included do
    # Define custom handlers
    ## For Invalid record and Routing error - 404
    rescue_from ActiveRecord::RecordInvalid, with: :four_not_four
    rescue_from ActionController::RoutingError, with: :four_not_four

    ## For Internal Server ever - 500
    rescue_from ExceptionHandler::InternalServerError, with: :five_zero_zero

    ## For others auth request - 401 - Unauthorized
    rescue_from ExceptionHandler::MissingAcceptHeader, with: :unauthorized_request
    rescue_from ExceptionHandler::WrongAcceptHeader, with: :unauthorized_request
  end

  private

  # JSON response with message; Status code 401 - Unauthorized
  def unauthorized_request(e)
    send_response = {
      status: 401,
      errors: {
        message: e.message
      }
    }
    json_response(send_response, :unauthorized)
  end

  # JSON response with message; Status code 404 - not found
  def four_not_four(e)
    send_response = {
      status: 404,
      errors: {
        message: e.message
      }
    }
    json_response(send_response, :not_found)
  end

  # JSON response with message; Status code 500 - internal server error
  def five_zero_zero(e)
    send_response = {
      status: 500,
      errors: {
        message: e.message
      }
    }
    json_response(send_response, :internal_server_error)
  end
end