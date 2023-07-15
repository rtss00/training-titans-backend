class ChangeMessageActorToInteger < ActiveRecord::Migration[7.0]
  def change
    remove_column :messages, :actor
    add_column :messages, :actor, :int, default: 0, null: false
  end
end
