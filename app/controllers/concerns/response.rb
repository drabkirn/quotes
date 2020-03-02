module Response
  ## Render JSON sending for requests. It's like a helper module.
  def json_response(object, status = :ok)
    render json: object, status: status
  end
end