class CreateMessage < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.string :actor
      t.string :content

      t.timestamps
    end
  end
end
