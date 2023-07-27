module ApplicationCable
  class Connection < ActionCable::Connection::Base
    include JsonWebToken

    identified_by :current_session
    rescue_from StandardError, with: :report_error

    def connect
      token = request&.params[:token]
      conversation_id = request&.params[:conversation_id]

      throw StandardError("Missing token") unless token.present?

      self.current_session = find_session(token, conversation_id)
    end

    private

    def report_error(e)
      reject_unauthorized_connection
    end

    def find_session(token, conversation_id)      
      token = jwt_decode(token)
      throw StandardError("Incorrect token") unless token.present?

      session = Session.find(token[:id])
      conversation = Conversation.find(conversation_id)

      if current_session = { session: Session.find(token[:id]), conversation: conversation }
        current_session
      else
        throw StandardError("Incorrect payload")
      end
    end
  end
end
