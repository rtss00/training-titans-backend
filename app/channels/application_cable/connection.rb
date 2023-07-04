module ApplicationCable
  class Connection < ActionCable::Connection::Base
    include JsonWebToken

    identified_by :current_session
    rescue_from StandardError, with: :report_error

    def connect
      token = request&.params[:token]
      throw StandardError("Missing token") unless token.present?
      self.current_session = find_session(token)
    end

    private

    def report_error(e)
      reject_unauthorized_connection
    end

    def find_session(token)
      token = jwt_decode(token)
      throw StandardError("Incorrect token") unless token.present?

      if current_session = Session.find(token[:id])
        current_session
      else
        throw StandardError("Incorrect payload")
      end
    end
  end
end
