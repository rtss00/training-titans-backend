class ChatChannel < ApplicationCable::Channel
  rescue_from StandardError, with: :report_model_error

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
    candidate_message_json = JSON.parse(completion['choices'][0]['message']['content'])
    candidate_message_content = candidate_message_json['answer']
    response = { message: candidate_message_content } 

    binding.pry
    report_model_error("Model returned an unexpected response") unless candidate_message_content.present?

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

  def terminate
    conversation = current_session[:conversation]
    service = OpenAiService.new(conversation: conversation)
    feedback_completion = service.terminate
    feedback = JSON.parse(feedback_completion['choices'][0]['message']['content'])
    
    ActionCable.server.broadcast(current_session, feedback)
  end

  def report_model_error(e)
    ActionCable.server.broadcast(current_session, { error: e.to_s })
  end
end
