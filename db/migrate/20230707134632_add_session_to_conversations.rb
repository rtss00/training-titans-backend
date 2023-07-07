class AddSessionToConversations < ActiveRecord::Migration[7.0]
  def change
    add_reference :conversations, :session, null: false, foreign_key: true
  end
end
