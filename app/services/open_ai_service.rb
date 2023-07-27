class OpenAiService
  def initialize(conversation:)
    @client = OpenAI::Client.new(access_token: Rails.application.credentials[:chatgpt])
    @conversation = conversation
  end

  def respond(prompt:)
    @client.chat(
      parameters: {
        model: "gpt-3.5-turbo-16k-0613",
        messages: messages,
        max_tokens: 2048
      }
    )
  end

  def terminate
    @client.chat(
      parameters: {
        model: "gpt-3.5-turbo-16k-0613",
        messages: finish,
        max_tokens: 2048
      }
    )
  end

  private

  def finish
    message_history = messages
    message_history.append(ending_message)
  end

  def messages
    message_history = @conversation.messages.select(:actor, :content).order(:created_at, :id).map do |message|
      if message.actor == 'candidate'
        candidate_message(message)
      else
        interviewer_message(message)
      end
    end

    message_history.insert(0, starting_prompt)
  end

  def starting_prompt
    profile_description = @conversation.candidate_profile.description
    renderer = TemplateRenderer.new(:start, binding)

    {
      role: :system,
      content: renderer.content
    }
  end

  def interviewer_message(message)
    interviewer_message = message.content
    confidence_level = nil
    renderer = TemplateRenderer.new(:interviewer_message, binding)

    {
      role: :user,
      content: renderer.content
    }
  end

  def candidate_message(message)
    candidate_message = message.content
    renderer = TemplateRenderer.new(:candidate_message, binding)

    {
      role: :assistant,
      content: renderer.content
    }
  end

  def ending_message
    renderer = TemplateRenderer.new(:ending_message, binding)

    {
      role: :system,
      content: renderer.content
    }
  end
end
