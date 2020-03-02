# Helper class to check if the request recieved is an API request
## If it's API, it will have `application/json` as content type.
class ApiRequestCheck

  def matches?(request)
    if check_content_type_header(request.content_type)
      true
    else
      false
    end
  end

  private

  def check_content_type_header(content_type)
    content_type && content_type == "application/json"
  end
end