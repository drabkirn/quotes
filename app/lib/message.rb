# Helper class for all custom messages used through the app
class Message
  # Quotes Messages
  def self.all_quotes_loaded
    "All Drabkirn Quotes loaded successfully"
  end

  def self.quote_loaded(id)
    "Drabkirn Quote with #{id} loaded successfully"
  end

  def self.missing_quotes_token_header
    "Error: Missing QuotesToken header in your request."
  end

  def self.wrong_quotes_token_header
    "Exception: You've included wrong QuotesToken header in your request."
  end

  # Users/appza Messages
  def self.users_callback_missing_params
    "Error: You're missing to send some important parameters. Check your request."
  end

  def self.user_database_updated
    "User database has been updated."
  end

  def self.user_loaded(id)
    "User with ID: #{id} loaded."
  end

  def self.user_destroyed(id)
    "User with ID: #{id} destroyed from Quotes database, however, data on Authna instance is still intact."
  end

  def self.wrong_auth_token
    "Wrong Authorization Token, please login again at Authna."
  end

  def self.missing_auth_token
    "Error: Missing Authorization Token."
  end

  def self.mising_appza_secret_header
    "Exception: Missing AppzaSecret Header in your request."
  end

  def self.wrong_appza_secret_header
    "Exception: You're using a wrong AppzaSecret Token."
  end

  # API Messages
  def self.exception_wrong_accept_header
    "Exception: You've included wrong Accept header in your request"
  end

  def self.exception_missing_accept_header
    "Exception: You've not included a valid Accept header in your request"
  end

  # System messages
  def self.action_not_found(record = 'record')
    "Error: Requested #{record} not found"
  end

  def self.exception_internal_server_error
    "Exception: 500 Internal Server error. There is something wrong from our end, check back soon or contact us"
  end
end