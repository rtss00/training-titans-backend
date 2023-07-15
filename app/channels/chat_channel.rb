class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from current_session
  end

  def unsubscribed; end

  def respond(data)
    response = "This is a dummy response. Use it  while we figure what to ask ChatGPT about."

    # interviewer_message = Message.create(content: data[:content], actor: :interviewer)
    # candidate_message = Message.create(content: response, actor: :candidate)

    ActionCable.server.broadcast(current_session, response)
  end
end
