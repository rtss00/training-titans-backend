class ChatChannel < ApplicationCable::Channel
  rescue_from StandardError, with: :report_error

  def subscribed
    stream_from current_session
  end

  def unsubscribed; end

  def respond(data)
    data = HashWithIndifferentAccess.new(data)
    conversation = current_session[:conversation]
    service = OpenAiService.new(conversation: conversation)
    prompt = data[:message]
    completion = service.respond(prompt: prompt)
    candidate_message_content = completion['choices'][0]['message']['content']
    response = { message: candidate_message_content } 

    interviewer_message = Message.create!(
      content: data[:message], 
      actor: :interviewer, 
      conversation: conversation)
    candidate_message = Message.create!(
      content: candidate_message_content, 
      actor: :candidate,
      conversation: conversation)

    ActionCable.server.broadcast(current_session, response)
  end

  def report_error(e)
    ActionCable.server.broadcast({ error: e.to_s })
  end
end
