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
end