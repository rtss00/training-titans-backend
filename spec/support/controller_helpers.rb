module ControllerHelpers
  include JsonWebToken

  def authenticate_request(session = nil)
    session ||= create(:session)
    payload = { id: session.id }
    request.headers['Authorization'] = "Bearer #{jwt_encode(payload)}"
    request.accept = 'application/json'
  end
end
