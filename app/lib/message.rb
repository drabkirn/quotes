class Message
  def self.all_quotes_loaded
    "All Drabkirn Quotes loaded successfully"
  end

  def self.quote_loaded(id)
    "Drabkirn Quote with #{id} loaded successfully"
  end

  def self.exception_wrong_accept_header
    "Exception: You've included wrong Accept header in your request"
  end

  def self.exception_missing_accept_header
    "Exception: You've not included a valid Accept header in your request"
  end

  def self.action_not_found(record = 'record')
    "Error: Requested #{record} not found"
  end

  def self.exception_internal_server_error
    "Exception: 500 Internal Server error. There is something wrong from our end, check back soon or contact us"
  end

  # Newsletter Messages
  def self.newsletter_email_subscribed
    "Your email is added to our newsletter successfully"
  end

  def self.newsletter_invalid_subscriber_info
    "Error: It looks like you've entered invalid email or name. Please try again with proper details"
  end

  def self.newsletter_unauthorized_request
    "Exception: You are not permitted to make this request"
  end
end