module Api
  class ApiController < ActionController::API
    include JsonWebToken

    respond_to :json

    before_action :authenticate

    def authenticate
      header = request.headers['Authorization']
      header = header.split(" ").last if header
      token = jwt_decode(header)

      @current_session = Session.find(token[:id])

    rescue JWT::DecodeError, ActiveRecord::RecordNotFound
      head :unauthorized
    end
  end
end
