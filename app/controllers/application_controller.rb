class ApplicationController < ActionController::Base
  # Include our concerns helpers
  include Response
  include ExceptionHandler

  before_action :accept_header_check_for_api_requests

  # When making invalid API-only requests, raise 404
  def action_not_found
    raise(ActionController::RoutingError, Message.action_not_found)
  end

  # When something is wrong in the app/server - API-only, raise 500
  def internal_server_error
    raise(ExceptionHandler::InternalServerError, Message.exception_internal_server_error)
  end

  private

    def accept_header_check_for_api_requests
      is_api_request = RequestTypeCheck.new.matches?(request)
      if is_api_request
        accept_header = request.headers["Accept"]
        accept_version = "v1"
        if accept_header.present?
          raise(ExceptionHandler::WrongAcceptHeader, Message.exception_wrong_accept_header) if accept_header != "application/drabkirn.quotes.#{accept_version}"
        else
          raise(ExceptionHandler::MissingAcceptHeader, Message.exception_missing_accept_header)
        end
      end
    end
end
