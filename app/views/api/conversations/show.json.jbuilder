json.id @conversation.id
json.session_id @conversation.session_id
json.target_profile_id @conversation.target_profile_id
json.id @conversation.id
json.created_at @conversation.created_at
json.messages @conversation.messages do |message|
  json.id message.id
  json.created_at message.created_at
  json.actor message.actor
  json.content message.content
end
