class RequestTypeCheck

  def matches?(request)
    # Return true if the request is API - JSON
    # Retun false if it's UI reqeust - Browser
    if check_for_api_content_type_header(request.content_type)
      true
    else
      false
    end
  end

  private

  def check_for_api_content_type_header(content_type)
    content_type && content_type == "application/json"
  end
end