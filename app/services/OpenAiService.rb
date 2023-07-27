class OpenAiService
  def initialize(conversation:)
    @client = OpenAI::Client.new(access_token: Rails.application.credentials[:chatgpt])
    @conversation = conversation
  end

  def respond(prompt:)
    messages = @conversation.messages.select(:actor, :content).order(:created_at, :id).map do |message|
      role = if message.actor == :candidate
               :assistant
             else
               :user
             end
      { role: role, content: message.content }
    end

    starting_prompt = {
      role: :system,
      content: 'You are a technical interview candidate for a Ruby on Rails position.'
    }

    messages.insert(0, starting_prompt)

    @client.chat(
      parameters: {
        model: "gpt-3.5-turbo-16k-0613",
        messages: messages,
        max_tokens: 2048
      }
    )
  end
end
