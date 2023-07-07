class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from current_session
  end

  def unsubscribed; end

  def receive(data)
    # Determine actions
    ActionCable.server.broadcast(current_session, data)
  end

  def respond(data)
    binding.pry
  end
end
