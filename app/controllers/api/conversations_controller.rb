module Api
  class ConversationsController < ApiController
    def index
      conversations = Conversation.where(session: @current_session)
      render json: conversations
    end

    def show
      conversation = Conversation.find(params[:id])
      render json: conversation 
    end

    def create
      params = conversation_params.merge(session: @current_session)
      conversation = Conversation.create(params)
      render json: conversation
    end

    private

    def conversation_params
      params.permit(:candidate_profile_id, :target_profile_id)
    end
  end
end
