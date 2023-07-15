class AddProfilesToConversation < ActiveRecord::Migration[7.0]
  def change
    change_table :conversations do |t|
      t.references :target_profile, foreign_key: { to_table: :profiles }
      t.references :candidate_profile, foreign_key: { to_table: :profiles }
    end
  end
end
