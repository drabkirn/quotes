module RequestSpecHelper
  # Parse JSON response to ruby hash
  def json
    JSON.parse(response.body)
  end
  
  def api_valid_headers
    {
      "Content-Type": "application/json",
      "Accept": "application/drabkirn.quotes.v1"
    }
  end

  def ui_valid_headers
    {
      "Accept": "application/drabkirn.quotes.v1"
    }
  end

  def api_invalid_headers_with_empty_accept_header
    {
      "Content-Type": "application/json",
      "Accept": ""
    }
  end

  def api_invalid_headers_with_wrong_accept_header
    {
      "Content-Type": "application/json",
      "Accept": "application/drabkirn.quotes.v11"
    }
  end
end