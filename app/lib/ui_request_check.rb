# Helper class to check if the request recieved is an API request
## If it's UI, it will have anything other than `application/json` as content type.
class UiRequestCheck
  
  def matches?(request)
    if check_content_type_header(request.content_type)
      false
    else
      true
    end
  end

  private

  def check_content_type_header(content_type)
    content_type && content_type == "application/json"
  end
end