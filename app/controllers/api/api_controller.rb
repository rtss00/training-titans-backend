class ApiController < ActionController::API
  include JsonWebToken

  before_action :authenticate

  def authenticate
    header = requests.headers['Authorization']
    header = header.split(" ").last if header
    token = jwt_decode(header)
    @current_session = Session.find(token[:id])
  end
end
