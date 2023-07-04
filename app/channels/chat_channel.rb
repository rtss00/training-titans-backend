class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'chat_channel'
    puts "subscribed: #{params}"
    binding.pry
  end

  def unsubscribed
    puts "unsubscribed: #{params}"
    binding.pry
  end

  def receive(data)
    puts data
    binding.pry
    ActionCable.server.broadcast("chat_channel", data)
  end
end
