class OpenAiService
  def initialize(conversation:)
    @client = OpenAI::Client.new(access_token: Rails.application.credentials[:chatgpt])
    @conversation = conversation
  end

  def respond(prompt:)
    @client.chat(
      parameters: {
        model: "gpt-3.5-turbo-16k-0613",
        messages: messages(prompt),
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
    message_history = messages(nil)
    message_history.append(ending_message)
  end

  def messages(prompt)
    message_history = @conversation.messages.select(:actor, :content).order(:created_at, :id).map do |message|
      if message.actor == 'candidate'
        candidate_message(message.content)
      else
        interviewer_message(message.content)
      end
    end
    
    base_prompts = [starting_prompt] + example_messages
    
    message_history = base_prompts + message_history
    message_history.append(interviewer_message(prompt)) if prompt.present?
    
    binding.pry
    message_history
  end

  def starting_prompt
    profile_description = @conversation.candidate_profile.description
    renderer = TemplateRenderer.new(:start, binding)

    {
      role: :system,
      content: renderer.content
    }
  end

  def interviewer_message(interviewer_message)
    confidence_level = nil
    renderer = TemplateRenderer.new(:interviewer_message, binding)

    {
      role: :user,
      content: renderer.content
    }
  end

  def candidate_message(candidate_message)
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

  def example_messages
    [
      interviewer_message('Are you ready to start our simulation?'),
      candidate_message('Yes! I am ready.')
    ]
  end
end
